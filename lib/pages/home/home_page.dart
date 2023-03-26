import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ontrack_backoffice/services/api_requests.dart';
import 'package:ontrack_backoffice/static/colors.dart';
import 'package:http/http.dart' as http;
import 'package:ontrack_backoffice/widgets/home_page/medium_screen/calendario.dart';
import 'package:ontrack_backoffice/widgets/home_page/medium_screen/medium_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: TextButton(
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: Text('OnTrack',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: Wrap(
                spacing: 15,
                children: [
                  TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/home');
                      },
                      child: Text('Home',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/ucs');
                      },
                      child: Text('Unidades Curriculares', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),)
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/avaliacoes');
                      },
                      child: Text('Avaliações', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),)
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/notificacoes');
                      },
                      child: Text('Notificações', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),)
                  ),
                  Icon(
                    Icons.logout,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: buildProfile(),
              decoration: BoxDecoration(
                color: primary,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: background,
          child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                child: Column(
                  children: [
                    // Container de UCs e Eventos de Avaliação
                    //TODO: Porque é que est+a a dar RenderFlex overflowed?
                    Row(
                    children: [
                      //UCs
                      buildUCsContainer(context),

                      //Eventos de Avaliação
                      buildListaEventosAvaliacao(context),
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

                    // Parte de baixo com o calendário e os detalhes do dia
                    Expanded(
                      child: Calendario()
                    )
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }


  Container buildUCsContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.4,

      child: FutureBuilder(
        future: getUCByProfID(context),
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
    );
  }

  Expanded buildListaEventosAvaliacao(BuildContext context) {
    return Expanded(
      child: Container(
        //color: Colors.red[600],
        height: MediaQuery.of(context).size.height * 0.4,
        child: Center(
            child: Stack(
              children: [
                //Container de fundo
                Container(
                  //Altura do Positioned
                  margin: EdgeInsets.only(top: 40),
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                  ),

                  //Container do ListView
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
                //Container do topo com o título
                Positioned(
                  // center positioned
                  child: Container(
                    decoration: BoxDecoration(
                      color: loginButtonColor,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    ),
                    height: 40,
                    width: double.infinity,
                      child: Center(child: Text('Próximas Avaliações', style: TextStyle(color: Colors.white, fontSize: 17), overflow: TextOverflow.ellipsis,))
                  )
                )
              ]
            )
        ),
      ),
    );
  }

}