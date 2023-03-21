import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calendario extends StatefulWidget {
  const Calendario({Key? key}) : super(key: key);

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  bool detalhesIsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Calendário
        buildCalendario(context),

        // Detalhes do dia do calendário
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                height: detalhesIsVisible ? MediaQuery.of(context).size.height * 0.34 : 0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blueGrey,
                ),
                child: Center(
                  child: const Text(
                    'Este é um container que aparece quando um dia é selecionado',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ),
      ],
    );
  }
  //height: MediaQuery.of(context).size.height * 0.34,
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
          //Título
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
                //color: Colors.lightGreenAccent,
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
        InkWell(
          onTap: () {
            // Vai mostrar o container dos detalhes do dia do calendário
            print('Dia $i');
            setState(() {
              detalhesIsVisible = !detalhesIsVisible;
              print(detalhesIsVisible);
            });
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Text(i.toString())),
          ),
        ),
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
}
