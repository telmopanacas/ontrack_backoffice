import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ontrack_backoffice/helpers/user_helper.dart';
import 'package:ontrack_backoffice/models/Avaliacao.dart';
import 'package:ontrack_backoffice/models/Notificacao.dart';

import '../widgets/api_data_widgets/api_data_helper.dart';

const _servidorOnTrackAPIEndpoint = 'https://642eb0988ca0fe3352d63279.mockapi.io';



Future<List<Widget>> getNotificacoes(String order) async {
  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/notificacao'));
  if(response.statusCode == 200) {
    var resultados = jsonDecode(response.body) as List;
    var notificacoes = resultados.map((notificacao) => Notificacao(notificacao['data'], notificacao['mensagem'])).toList();
    if(order == 'New-Old'){
      notificacoes.sort((a, b) => DateFormat('dd/MM/yyyy').parse(b.data).compareTo(DateFormat('dd/MM/yyyy').parse(a.data)));
    }else {
      notificacoes.sort((a, b) => DateFormat('dd/MM/yyyy').parse(a.data).compareTo(DateFormat('dd/MM/yyyy').parse(b.data)));
    }


    var jsonResponse= notificacoes.map((notificacao) => getNotificacaoWidget(notificacao)).toList();
    return jsonResponse;
  }else {
    print('Request failed with status: ${response.statusCode}.');
    return [];
  }
}

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
    print('Request update failed with status: ${response.statusCode}.');
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

Future<bool> createAvaliacao(Map<String, dynamic> avaliacao) async {
  // Id do professor
  var idProf = 1;

  var response = await http.post(Uri.parse('${_servidorOnTrackAPIEndpoint}/professor/$idProf/evento_avaliacao'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(avaliacao));
  if (response.statusCode == 201) {
    return true;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return false;
  }
}

Future<Map<String, dynamic>> getAvaliacao(String id) async {
  // Id do professor
  var idProf = 1;

  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/professor/$idProf/evento_avaliacao/$id'));
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  } else {
    print('Request getAvaliacao failed with status: ${response.statusCode}.');
    return {};
  }
}

Future<Map<String, dynamic>> getUC(String id) async {
  // Id do professor
  var idProf = 1;

  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/professor/$idProf/unidade_curricular/$id'));
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  } else {
    print('Request getUC failed with status: ${response.statusCode}.');
    return {};
  }
}


Future<List<Widget>> getUCsProf(BuildContext context) async {
  // Id do professor
  var idProf = professor.id;

  //var url = "${_servidorOnTrackAPIEndpoint}/professor/$idProf/unidade_curricular";
  var temp_url = "http://localhost:8094/api/v1/professor/${idProf}/unidades-curriculares/list";

  var response = await http.get(Uri.parse('${temp_url}'));
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
  var idProf = professor.id;

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

Future<List<Widget>> getAvaliacoesByUC(BuildContext context, String ucId) async {
  // Id do professor
  var idProf = 1;

  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/professor/$idProf/evento_avaliacao'));
  if(response.statusCode == 200) {
    var resultados = jsonDecode(response.body) as List;
    var jsonResponse = resultados.where((avaliacao) => avaliacao['estado'] == 'A decorrer' && avaliacao['ucId'] == ucId)
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

Future<List<Widget>> getEventosProfID(BuildContext context) async {
  // Id do professor
  var idProf = 1;

  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/professor/$idProf/evento_avaliacao'));
  if (response.statusCode == 200) {
    var resultados = jsonDecode(response.body) as List;
    var jsonResponse = resultados.map((evento) => getHomeAvaliacoesWidgetFromJSON(context, evento, Colors.white)).toList();
    return jsonResponse;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return [];
  }
}

Future<List<Widget>> getEventosProfessorDiaX(BuildContext context, DateTime selectedDay) async{
  // Id do professor
  var idProf = 1;

  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/professor/$idProf/evento_avaliacao'));
  if (response.statusCode == 200) {
    List<Widget> output = [];
    var resultados = jsonDecode(response.body) as List;
    resultados.map((evento)  {
      if(evento['data_realizacao'] == DateFormat('dd/MM/yyyy').format(DateTime(selectedDay.year, selectedDay.month, selectedDay.day))){
        output.add(getHomeAvaliacoesWidgetFromJSON(context, evento, Colors.grey[300]));
      }
    }).toList();
    return output;
  } else {
    print('Erro ao carregar os eventos do dia');
    return [];
  }
}