import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


const _servidorOnTrackAPIEndpoint = 'http://localhost:8094/api/v1/login';

Future<int> login(String email, String password) async {
  /*
  Quando for para utilizar a password, não esquecer encryptar a mesma
   */
  var body = jsonEncode({
    'email': email,
    'password': password
  });

  var response = await http.post(Uri.parse(_servidorOnTrackAPIEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body
  );
  if (response.statusCode == 200) {

    var jsonResponse = jsonDecode(response.body);
    return jsonResponse['id'];
  } else {

    print('Request failed with status: ${response.statusCode}.');
    return 0;
  }
}