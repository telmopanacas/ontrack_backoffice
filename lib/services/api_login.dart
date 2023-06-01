import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


const _servidorOnTrackAPIEndpoint = 'http://localhost:8080/api/v1/login';

Future<bool> login(String email) async {
  var url = _servidorOnTrackAPIEndpoint+'?email=$email';
  print(url);
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return true;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return false;
  }
}