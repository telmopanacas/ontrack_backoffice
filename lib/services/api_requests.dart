import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../widgets/api_data_widgets/api_data_helper.dart';

const _servidorOnTrackAPIEndpoint = 'https://642eb0988ca0fe3352d63279.mockapi.io';

Future<bool> updateAvaliacao(Map<String, dynamic> avaliacao) async {
  // Id do professor
  var idProf = 1;

  var response = await http.put(Uri.parse('${_servidorOnTrackAPIEndpoint}/professor/$idProf/evento_avaliacao/${avaliacao['id']}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(avaliacao));
  if (response.statusCode == 200) {
    return true;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return false;
  }
}

Future<bool> deleteAvaliacao(int id) async {
  // Id do professor
  var idProf = 1;

  var response = await http.delete(Uri.parse('${_servidorOnTrackAPIEndpoint}/professor/$idProf/evento_avaliacao/$id'));
  if (response.statusCode == 200) {
    return true;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return false;
  }
}

Future<List<Widget>> getUCByProfID(BuildContext context) async {
  // Id do professor
  var idProf = 1;

  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/professor/$idProf/unidade_curricular'));
  if (response.statusCode == 200) {
    var resultados = jsonDecode(response.body) as List;
    var jsonResponse = resultados.map((uc) => getUCWidgetFromJSON(context, uc)).toList();
    return jsonResponse;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return [];
  }
}

Future<List<Widget>> getAvaliacoes(BuildContext context, String estado) async {
  // Id do professor
  var idProf = 1;

  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/professor/$idProf/evento_avaliacao'));
  if(response.statusCode == 200) {
    var resultados = jsonDecode(response.body) as List;
    var jsonResponse = resultados.where((avaliacao) => avaliacao['estado'] == estado)
                                  .map((avaliacao) => getAvaliacoesWidgetFromJSON(context, avaliacao))
                                  .toList();
    return jsonResponse;
  }else {
    print('Request failed with status: ${response.statusCode}.');
    return [];
  }
}

Future<List<Widget>> getUCProfByAnoLetivo(BuildContext context, String anoLetivo) async {
  // Id do professor
  var idProf = 1;

  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/professor/$idProf/unidade_curricular'));
  if (response.statusCode == 200) {
    List<Widget> output = [];
    var resultados = jsonDecode(response.body) as List;
    resultados.map((uc) {
      if(uc['ano'] == anoLetivo){
        output.add(getUCWidgetFromJSON(context, uc));
      }
    }).toList();
    return output;
  } else {
    print('Erro ao carregar as unidades curriculares');
    return [];
  }
}

Future<List<Widget>> getEventosProfID() async {
  // Id do professor
  var idProf = 1;

  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/professor/$idProf/evento_avaliacao'));
  if (response.statusCode == 200) {
    var resultados = jsonDecode(response.body) as List;
    var jsonResponse = resultados.map((evento) => getHomeAvaliacoesWidgetFromJSON(evento, Colors.white)).toList();
    return jsonResponse;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return [];
  }
}

Future<List<Widget>> getEventosProfessorDiaX(DateTime selectedDay) async{
  // Id do professor
  var idProf = 1;

  var response = await http.get(Uri.parse('https://6419c06ec152063412cb0109.mockapi.io/professor/$idProf/evento_avaliacao'));
  if (response.statusCode == 200) {
    List<Widget> output = [];
    var resultados = jsonDecode(response.body) as List;
    resultados.map((evento)  {
      if(evento['data_realizacao'] == DateFormat('dd/MM/yyyy').format(DateTime(selectedDay.year, selectedDay.month, selectedDay.day))){
        output.add(getHomeAvaliacoesWidgetFromJSON(evento, Colors.grey[300]));
      }
    }).toList();
    return output;
  } else {
    print('Erro ao carregar os eventos do dia');
    return [];
  }
}