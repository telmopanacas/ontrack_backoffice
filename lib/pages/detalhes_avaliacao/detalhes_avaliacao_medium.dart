import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ontrack_backoffice/services/api_requests.dart';
import 'package:ontrack_backoffice/static/colors.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar.dart';
import 'package:table_calendar/table_calendar.dart';

class DetalhesAvaliacaoMedium extends StatefulWidget {
  const DetalhesAvaliacaoMedium({Key? key}) : super(key: key);

  @override
  State<DetalhesAvaliacaoMedium> createState() => _DetalhesAvaliacaoMediumState();
}

class _DetalhesAvaliacaoMediumState extends State<DetalhesAvaliacaoMedium> {
  @override
  Widget build(BuildContext context) {
    final avaliacao = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final data_realizacao = DateFormat('dd/MM/yyyy').parse(avaliacao['data_realizacao']);
    final alturaDetalhes = 400.0;


    return Scaffold(
      appBar: buildAppBar(context, 'Avaliações'),
      //drawer: buildDrawer(context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        color: background,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
                  child: Column(
                    children: [
                      Text(
                        'Detalhes Avaliação',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50,),
                      Text(
                        '${avaliacao['name']}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50,),
                      Container(
                        width: 1200,
                        constraints: BoxConstraints(
                          minHeight: alturaDetalhes,
                        ),
                        child: Row(
                          children: [
                            buildDetalhesAvaliacao(alturaDetalhes, avaliacao, data_realizacao),
                            buildCalendarioContainer(alturaDetalhes, data_realizacao),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: 100,
              child: Wrap(
                spacing: 10,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(100, 40),
                    ),
                    onPressed: () async {
                      Navigator.pushNamed(context, '/editar_avaliacao');
                    },
                    child: Text('Editar'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(100, 40),
                    ),
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Eliminar Avaliação'),
                            content: Text('Tem a certeza que pretende eliminar esta avaliação?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await deleteAvaliacao(int.parse(avaliacao['id']));
                                  Navigator.pushReplacementNamed(context, '/avaliacoes');
                                },
                                child: Text('Eliminar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Eliminar'),
                  ),
                ],
              ),
            )
          ]
        ),
      ),
    );
  }

  Expanded buildCalendarioContainer(double alturaDetalhes, DateTime data_realizacao) {
    return Expanded(
      child: Container(
        constraints: BoxConstraints(
          minHeight: alturaDetalhes,
        ),
        child: buildCalendario(data_realizacao),
      ),
    );
  }

  TableCalendar<dynamic> buildCalendario(DateTime data_realiazacao) {
    return TableCalendar(
      locale: 'pt_PT',
      /*
      * Header do calendário
      * Onde se encontra o título, os botões de avançar e retroceder mês
      * No HeaderStyle é possível definir o estilo do título, dos botões e se estes são visíveis
       */
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        leftChevronIcon: Icon(Icons.arrow_back_ios, color: Colors.black,),
        rightChevronIcon: Icon(Icons.arrow_forward_ios, color: Colors.black,),
      ),
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: data_realiazacao,
      calendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.monday,
      /*
      * Dias da semana
      * No DaysOfWeekStyle é possível definir o estilo dos dias da semana
       */
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        weekendStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      availableGestures: AvailableGestures.all,
      // O que acontece quando se clica num dia
      selectedDayPredicate: (day) => isSameDay(data_realiazacao, day),
      /*
      * Estilo do calendário
      * No CalendarStyle é possível definir o estilo dos dias normais,
      * dos dias de fim de semana, dos dias fora do mês, dos dias selecionados
      * e dos dias de hoje
       */
      calendarStyle: CalendarStyle(
        outsideTextStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        weekendTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        defaultTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        selectedDecoration: BoxDecoration(
          color: primary,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),

      ),
    );
  }

  Expanded buildDetalhesAvaliacao(double alturaDetalhes, Map<String, dynamic> avaliacao, DateTime data_realizacao) {
    final dataOutput = data_realizacao.isAfter(DateTime.now()) ? '${data_realizacao.difference(DateTime.now()).inDays} dias' : 'Terminada';

    return Expanded(
      child: Container(
        constraints: BoxConstraints(
          minHeight: alturaDetalhes,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'Unidade Curricular: ',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                children: <TextSpan>[
                  TextSpan(text: avaliacao['ucId'], style: TextStyle(fontWeight: FontWeight.normal)),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Tipo de avaliação: ',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                children: <TextSpan>[
                  TextSpan(text: avaliacao['tipo'], style: TextStyle(fontWeight: FontWeight.normal)),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Método de entrega: ',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                children: <TextSpan>[
                  TextSpan(text: avaliacao['metodo_entrega'], style: TextStyle(fontWeight: FontWeight.normal)),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Tempo restante: ',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                children: <TextSpan>[
                  TextSpan(text: dataOutput, style: TextStyle(fontWeight: FontWeight.normal)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
