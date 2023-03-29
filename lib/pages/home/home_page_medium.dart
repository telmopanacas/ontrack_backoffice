import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/services/api_requests.dart';
import 'package:ontrack_backoffice/static/colors.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar.dart';
import 'package:ontrack_backoffice/widgets/app_bar/drawer.dart';
import 'package:ontrack_backoffice/widgets/calendario/calendario.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePageMedium extends StatelessWidget {
  const HomePageMedium({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Home'),
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: background,

          child: Center(
              child: Column(
                children: [

                  ExpansionTile(
                    shape: Border(),
                    title: Center(
                        child: Text(
                          'As suas unidades Curriculares',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )
                        )
                    ),
                    textColor: Colors.black,
                    initiallyExpanded: true,
                    children: [
                      // Container de UCs
                      buildUCsContainer(context)
                    ]
                  ),
                  SizedBox(height: 20,),
                  ExpansionTile(
                    shape: Border(),
                    title: Center(
                        child: Text(
                            'Eventos e Avaliações',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )
                        )
                    ),
                    textColor: Colors.black,
                    initiallyExpanded: true,
                    children: [
                      // Container de Eventos e Avaliações

                      Calendario()
                    ]
                  ),

                  // Parte de baixo com o calendário e os detalhes do dia
                  /*
                  Expanded(
                    child: Calendario()
                  ),
                   */
                ],
              )
          ),
        ),
      ),
    );
  }


  Padding buildUCsContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
        color: Colors.redAccent,
        //width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height * 0.4,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.4,
        ),
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
