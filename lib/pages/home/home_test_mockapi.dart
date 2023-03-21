import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/controllers/api_requests.dart';
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

                // Container de UCs e Eventos de Avaliação
                //TODO: Porque é que est+a a dar RenderFlex overflowed?
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

                    //Eventos de Avaliação
                    Expanded(
                      child: Container(
                        //color: Colors.red[600],
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Center(
                            child: Stack(
                              children: [
                                Container(
                                  //Altura do Positioned
                                  margin: EdgeInsets.only(top: 40),
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                  ),
                                  child: SizedBox.expand(
                                    child: Container(
                                        //color: Colors.deepOrange,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListView(
                                            children: [
                                              FutureBuilder(
                                                future: getEventosProfID(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return SingleChildScrollView(
                                                      scrollDirection: Axis.vertical,
                                                      child: Wrap(
                                                        runSpacing: 10,
                                                        alignment: WrapAlignment.start,
                                                        children: snapshot.data as List<Widget>,
                                                      ),
                                                    );
                                                  } else {
                                                    return Center(child: CircularProgressIndicator());
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
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
                                    height: 40,
                                    width: double.infinity,
                                      child: Center(child: Text('Eventos de Avaliação', style: TextStyle(color: Colors.white, fontSize: 17),))
                                  )
                                )
                              ]
                            )
                        ),
                      ),
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

}
