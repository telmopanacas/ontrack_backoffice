import 'package:flutter/material.dart';
import 'dart:math' as math;

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

Widget getEventoWidgetFromJSON(Map<String, dynamic> json){
  return InkWell(
    onTap: () {
      //TODO - Ir para os detalhes do evento
      print('Carregou em evento: ${json['name']}');
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('${json['name']}',
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.class_outlined, size: 15,),
                    SizedBox(width: 5,),
                    Text('${json['tipo']}', style: TextStyle(overflow: TextOverflow.ellipsis),),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.insert_invitation_outlined, size: 15,),
                    SizedBox(width: 5,),
                    Text('${json['data_realizacao']}', style: TextStyle(overflow: TextOverflow.ellipsis),),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}