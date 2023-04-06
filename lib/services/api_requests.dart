import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../widgets/api_data_widgets/api_data_helper.dart';

const _servidorOnTrackAPIEndpoint = 'https://642eb0988ca0fe3352d63279.mockapi.io';

Future<List<Widget>> getUCByProfID(BuildContext context) async {
  // Id do professor
  var id = 1;

  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/professor/$id/unidade_curricular'));
  if (response.statusCode == 200) {
    var resultados = jsonDecode(response.body) as List;
    var jsonResponse = resultados.map((uc) => getUCWidgetFromJSON(context, uc)).toList();
    return jsonResponse;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return [];
  }
}

Future<List<Widget>> getUCProfByAnoLetivo(BuildContext context, String anoLetivo) async {
  // Id do professor
  var id = 1;

  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/professor/$id/unidade_curricular'));
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
  var id = 1;

  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/professor/$id/evento_avaliacao'));
  if (response.statusCode == 200) {
    var resultados = jsonDecode(response.body) as List;
    var jsonResponse = resultados.map((evento) => getEventoWidgetFromJSON(evento, Colors.white)).toList();
    return jsonResponse;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return [];
  }
}

Future<List<Widget>> getEventosProfessorDiaX(DateTime selectedDay) async{
  // Id do professor
  var id = 1;

  var response = await http.get(Uri.parse('https://6419c06ec152063412cb0109.mockapi.io/professor/$id/evento_avaliacao'));
  if (response.statusCode == 200) {
    List<Widget> output = [];
    var resultados = jsonDecode(response.body) as List;
    resultados.map((evento)  {
      if(evento['data_realizacao'] == DateFormat('dd/MM/yyyy').format(DateTime(selectedDay.year, selectedDay.month, selectedDay.day))){
        output.add(getEventoWidgetFromJSON(evento, Colors.grey[300]));
      }
    }).toList();
    return output;
  } else {
    print('Erro ao carregar os eventos do dia');
    return [];
  }
}