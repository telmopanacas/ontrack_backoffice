import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/static/colors.dart';
import 'package:http/http.dart' as http;

class HomePageAPI extends StatelessWidget {
  const HomePageAPI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    testarApi();
    return Container(
      color: background,
      child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Column(
              children: [
                Text('Home', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                SizedBox(height: 40,),
                Row(
                  children: [
                    Container(
                      color: Colors.orange[200],
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: FutureBuilder(
                        future: testarApi(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: snapshot.data as List<Widget>,
                              ),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                    Expanded(
                        child: Container(
                          color: Colors.red[600],
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Center(child: Text('Lista de eventos de avaliação')),
                        )
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey[400],
                  height: 40,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
                Row(
                  children: [
                    Container(
                      color: Colors.blue[200],
                      height: MediaQuery.of(context).size.height * 0.34,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Center(child: Text('Calendário')),
                    ),
                    Expanded(
                        child: Container(
                          color: Colors.green[600],
                          height: MediaQuery.of(context).size.height * 0.34,
                          child: Center(child: Text('Detalhes do dia do calendário')),
                        )
                    ),
                  ],
                )
              ],
            ),
          )
      ),
    );
  }

  Future<List<Widget>> testarApi() async {
    var response = await http.get(Uri.parse('https://6411e71a6e3ca31753014d37.mockapi.io/users'));
    if (response.statusCode == 200) {
      var resultados = jsonDecode(response.body) as List;
      var jsonResponse = resultados.map((e) => getWidgetFromJSON(e)).toList();
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }

  Widget getWidgetFromJSON(Map<String, dynamic> json) {
    return Container(
      color: Colors.grey[400],
      child: Column(
        children: [
          Text('Name: ${json['name']}'),
          Text('ID: ${json['id']}'),
        ],
      ),
    );
  }
}
