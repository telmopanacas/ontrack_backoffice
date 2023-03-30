import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ontrack_backoffice/services/api_requests.dart';
import 'package:ontrack_backoffice/static/colors.dart';
import 'package:ontrack_backoffice/widgets/animatedContainer.dart';
import 'package:ontrack_backoffice/widgets/api_data_widgets/api_data_helper.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar.dart';
import 'package:ontrack_backoffice/widgets/app_bar/drawer.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePageMedium extends StatefulWidget {
  const HomePageMedium({Key? key}) : super(key: key);

  @override
  State<HomePageMedium> createState() => _HomePageMediumState();
}

class _HomePageMediumState extends State<HomePageMedium> {
  DateTime today = DateTime.now();

  /*
  * Função que vai ser chamada pelo TableCalendar quando se clica num dia
  * Esta função vai mostrar um AlertDialog com os eventos e avaliações do dia
  * O AlertDialog vai ter um FutureBuilder que vai fazer um pedido à API
  * para obter os eventos e avaliações do dia.
  * O FutureBuilder vai mostrar um CircularProgressIndicator enquanto o pedido
  * não for feito.
  * Se o pedido for feito com sucesso e não houver eventos para o dia, vai mostrar
  * uma mensagem a dizer que não há eventos para o dia.
  * Se o pedido for feito com sucesso e houver eventos para o dia, vai mostrar
  * uma lista com os eventos e avaliações do dia.
  * No final vai alterar o estado da variável today para o dia selecionado.
   */
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Eventos e Avaliações para o dia ${DateFormat('dd/MM/yyyy').format(selectedDay)}'),
          content: SingleChildScrollView(
            child: FutureBuilder(
              future: getEventosProfessorDiaX(selectedDay),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  // O pedido foi feito com sucesso e não há eventos para o dia
                  if(snapshot.data.toString() == '[]') {
                    return Center(
                        child: Text(
                          'Não há eventos para este dia',
                          style: TextStyle(
                              color: Colors.black, fontSize: 17),
                        )
                    );
                  }
                  // O pedido foi feito com sucesso e há eventos para o dia
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: snapshot.data as List<Widget>,
                  );
                }else{
                  // O pedido ainda não foi feito
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              ),
          ),
          actions: [
            TextButton(
              child: Text('Fechar', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        )
    );
    setState(() {
      today = selectedDay;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Home'),
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          color: background,
          child: Stack(
            children: [
              Column(
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
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: buildUCsContainer(context),
                      )
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
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: buildCalendario(),
                      ),
                    ]
                  ),
              ],
            ),
              Positioned(
                right: 0,
                top: 80,
                child: AnimatedContainerExample(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*
  * Função que constrói o calendário
   */
  TableCalendar<dynamic> buildCalendario() {
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
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        leftChevronIcon: Icon(Icons.arrow_back_ios, color: Colors.black,),
        rightChevronIcon: Icon(Icons.arrow_forward_ios, color: Colors.black,),
      ),
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: today,
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
      onDaySelected: _onDaySelected,
      selectedDayPredicate: (day) => isSameDay(today, day),
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

  /*
  * Função que constrói o container das UCs
  * O container é construído com um FutureBuilder
  * O FutureBuilder vai fazer um pedido ao servidor para obter as UCs do professor
  * O pedido é feito com a função getUCByProfID
  * O FutureBuilder vai construir o container com base no que o pedido devolver
  * Se o pedido ainda não tiver sido feito, o FutureBuilder vai mostrar um CircularProgressIndicator
  * Se o pedido tiver sido feito com sucesso, o FutureBuilder vai construir o container com base no que o pedido devolver
   */
  Container buildUCsContainer(BuildContext context) {
    return Container(
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
    );
  }

}
