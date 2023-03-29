import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/api_data_widgets/api_data_helper.dart';

const _servidorDeisiAPIEndpoint = 'https://6424a7567ac292e3cfef0a9c.mockapi.io';
const _servidorOnTrackAPIEndpoint = 'https://6419c06ec152063412cb0109.mockapi.io';

Future<List<Widget>> getUCByProfID(BuildContext context) async {
  // Id do professor
  var id = 1;

  var response = await http.get(Uri.parse('${_servidorDeisiAPIEndpoint}/professores/$id/unidades_curriculares'));
  if (response.statusCode == 200) {
    var resultados = jsonDecode(response.body) as List;
    var jsonResponse = resultados.map((uc) => getUCWidgetFromJSON(context, uc)).toList();
    return jsonResponse;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return [];
  }
}

Future<List<Widget>> getEventosProfID() async {
  // Id do professor
  var id = 1;

  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/professores/$id/evento_avaliacao'));
  if (response.statusCode == 200) {
    var resultados = jsonDecode(response.body) as List;
    var jsonResponse = resultados.map((evento) => getEventoWidgetFromJSON(evento, Colors.white)).toList();
    return jsonResponse;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return [];
  }
}