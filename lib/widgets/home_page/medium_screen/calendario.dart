import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ontrack_backoffice/static/colors.dart';

class Calendario extends StatefulWidget {
  const Calendario({Key? key}) : super(key: key);

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  /*
  * Variáveis
  * _detalhesIsVisible - Se os detalhes do dia estão visíveis ou não
  * _lastDaySelected - Último dia selecionado no calendário
  * _diaSelecionado - Dia selecionado no calendário
   */
  bool _detalhesIsVisible = false;
  int _lastDaySelected = 0;
  List<int> selectedDays = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Calendário
        buildCalendario(context),

        // Eventos do dia do calendário
        buildEventosDoDiaSelecionado(context),
      ],
    );
  }

  /*
  * Função que constrói o calendário
  * Vai ser um expanded para que ocupe o espaço disponível, que tem padding do lado direito e esquerdo
  * Vem então a seguir um AnimatedContainer que vai ter a altura do calendário quando estiver visível e 0 quando não estiver
  * Dentro do AnimatedContainer vem um Stack onde o primeiro filho é o container com os nossos eventos
  * E o segundo filho é um container com o título 'Eventos de Avaliação do dia X'.
  *
  * Dentro do AnimatedContainer temos primeiro um container branco que vai ser o container dos eventos
  * Temos um padding de 8 para que não fique muito colado à borda
  * E temos um ListView que vai ser o que vai conter os eventos do dia
  * No ListView temos um FutureBuilder pois temos que ir buscar a informçaão à API
  * O FutureBuilder vai ter como future o getEventosDiaX() que vai buscar a informação à API
  * Esse getEventosDiaX() vai retornar uma Lista de Widgets com os eventos
  * Caso não tenha dados, vai retornar um Text a dizer que não há eventos para esse dia
  * Caso tenha dados, vai retornar um SingleChildScrollView com um Wrap que vai conter os eventos
   */
  Expanded buildEventosDoDiaSelecionado(BuildContext context) {
    return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              height: _detalhesIsVisible ? MediaQuery.of(context).size.height * 0.34 : 0,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                    ),
                    height: MediaQuery.of(context).size.height * 0.34,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: [
                          FutureBuilder(
                            future: getEventosDiaX(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if(snapshot.data.toString() == '[]') {
                                  return Center(
                                      child: Text(
                                        'Não há eventos para este dia',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 17),
                                      )
                                  );
                                }
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
                        ]
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
                          child: Center(child: Text('Eventos de Avaliação do dia ${_lastDaySelected}', style: TextStyle(color: Colors.white, fontSize: 17),))
                      )
                  )
                ]
              )
            ),
          ),
      );
  }


  Container buildCalendario(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: MediaQuery.of(context).size.height * 0.34,
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        children: [
          // Container com o titulo
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              //color: Colors.orange,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Center(
                child: Text(
                  getMonth(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
            ),
          ),
          //Calendário
          Container(
              height: MediaQuery.of(context).size.height * 0.34 - 40,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              child: GridView.count(
                padding: EdgeInsets.all(10),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 10,
                children: getCalendarDays(),
              )
          ),
        ],
      ),
    );
  }

  String getMonth(){
    return capitalize(DateFormat('MMMM','pt').format(DateTime.now()));
  }
  String capitalize(String str) {
    return str.replaceRange(0, 1, str[0].toUpperCase());
  }

  List<Widget> getCalendarDays() {

    List<Widget> calendarDays = [];
    for (int i = 1; i <= getNumberOfDaysMonth(); i++) {
      calendarDays.add(
        diaCalendario(i, selectedDays),
      );
    }
    return calendarDays;
  }

  int getNumberOfDaysMonth(){

    final month = DateTime.now().month.toString();

    if(month =='1' || month =='3' || month =='5' || month =='7' || month =='8' || month =='10' || month =='12'){
      return 31;
    }else if(month =='4' || month =='6' || month =='9' || month =='11'){
      return 30;
    }else{
      return 28;
    }
  }

  Future<List<Widget>> getEventosDiaX() async{
    // Id do professor
    var id = 1;

    var response = await http.get(Uri.parse('https://6419c06ec152063412cb0109.mockapi.io/professores/$id/evento_avaliacao'));
    if (response.statusCode == 200) {
      List<Widget> output = [];
      var resultados = jsonDecode(response.body) as List;
      resultados.map((evento)  {
        if(evento['data_realizacao'] == DateFormat('dd/MM/yyyy').format(DateTime(DateTime.now().year, DateTime.now().month, _lastDaySelected))){
          output.add(getWidgetEventoDia(evento));
        }
      }).toList();
      return output;
    } else {
      print('Erro ao carregar os eventos do dia');
      return [];
    }
  }
  
  Widget getWidgetEventoDia(Map<String, dynamic> json) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: Text(json['name'])),
    );
  }
  
  Widget diaCalendario(int i, List<int> selectedDays) {
    bool selected = selectedDays.contains(i);
    return InkWell(
      onTap: () {
        // Vai mostrar o container dos detalhes do dia do calendário
        if(_lastDaySelected != i && _detalhesIsVisible == true){
          setState(() {
            _lastDaySelected = i;
            // chamar a função que vai buscar os dados do dia selecionado
            selectedDays.clear();
            if (selected) {
              selectedDays.remove(i);
            } else {
              selectedDays.add(i);
            }
          });
        }
        else{
          setState(() {
            _lastDaySelected = i;
            _detalhesIsVisible = !_detalhesIsVisible;
            // chamar a função que vai buscar os dados do dia selecionado
            if (selected) {
              selectedDays.remove(i);
            } else {
              selectedDays.add(i);
            }
          });
        }
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: selected ? loginButtonColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(i.toString(), style: TextStyle(fontSize: 20, color: selected ? Colors.white : Colors.black),),
        ),
      ),
    );
  }
}
