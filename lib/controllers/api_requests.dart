import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/api_data_widgets/api_data_helper.dart';

Future<List<Widget>> getUCByProfID() async {
  // Id do professor
  var id = 1;

  var response = await http.get(Uri.parse('https://6411e71a6e3ca31753014d37.mockapi.io/professores/$id/unidades_curriculares'));
  if (response.statusCode == 200) {
    var resultados = jsonDecode(response.body) as List;
    var jsonResponse = resultados.map((uc) => getUCWidgetFromJSON(uc)).toList();
    return jsonResponse;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return [];
  }
}

Future<List<Widget>> getEventosProfID() async {
  // Id do professor
  var id = 1;

  var response = await http.get(Uri.parse('https://6419c06ec152063412cb0109.mockapi.io/professores/$id/evento_avaliacao'));
  if (response.statusCode == 200) {
    var resultados = jsonDecode(response.body) as List;
    var jsonResponse = resultados.map((evento) => getEventoWidgetFromJSON(evento)).toList();
    return jsonResponse;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return [];
  }
}