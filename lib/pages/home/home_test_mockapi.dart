import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/controllers/controllers.dart';
import 'package:ontrack_backoffice/static/colors.dart';
import 'package:http/http.dart' as http;

class HomePageAPI extends StatelessWidget {
  const HomePageAPI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Column(
              children: [
                Text('Home', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                SizedBox(height: 40,),

                // Container de UCs
                Row(
                  children: [
                    //UCs
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.4,

                      child: FutureBuilder(
                        future: getUCByProfID(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Wrap(
                                spacing: 15,
                                runSpacing: 15,
                                alignment: WrapAlignment.start,
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
                          //color: Colors.red[600],
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Center(
                              child: Stack(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.4,
                                    width: MediaQuery.of(context).size.width * 0.15,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                                      child: Column(
                                        children: [
                                          Text('Lista de Eventos'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // center positioned
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: loginButtonColor,
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                      ),
                                      height: MediaQuery.of(context).size.height * 0.08,
                                      width: MediaQuery.of(context).size.width * 0.15,
                                        child: Center(child: Text('Eventos de Avaliação', style: TextStyle(color: Colors.white),))
                                    )
                                  )
                                ]
                              )
                          ),
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
                //TODO: Pesquisar sobre o Flexible
                Flexible(
                  child: Row(
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
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

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

  Widget getUCWidgetFromJSON(Map<String, dynamic> json) {
    return InkWell(
      onTap: () {
        //TODO - Ir para os detalhes da UC
        print('Carregou em UC: ${json['name']}');

      },
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                //TODO: Tornar cores fixas
                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              child: Center(
                  child: Text(
                    json['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
              ),
            ),
            Container(
              width: 150,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20,15,0,0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Curso: ',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(text: json['curso'], style: TextStyle(fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    RichText(
                      text: TextSpan(
                        text: 'Ano Letivo: ',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(text: json['ano'].toString(), style: TextStyle(fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    RichText(
                      text: TextSpan(
                        text: 'Semestre: ',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(text: json['semestre'].toString(), style: TextStyle(fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
