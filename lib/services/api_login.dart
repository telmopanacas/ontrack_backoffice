import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


const _servidorOnTrackAPIEndpoint = 'http://localhost:8094/api/v1/login';

Future<int> login(String email) async {
  var url = _servidorOnTrackAPIEndpoint+'?email=$email';
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {

    var jsonResponse = jsonDecode(response.body);
    return jsonResponse['id'];
  } else {

    print('Request failed with status: ${response.statusCode}.');
    return 0;
  }
}