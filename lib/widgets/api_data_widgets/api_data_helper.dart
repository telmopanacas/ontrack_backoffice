import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:ontrack_backoffice/static/colors.dart';

Widget getAvaliacoesWidgetFromJSON(BuildContext context, Map<String, dynamic> json) {
  double larguraCard = 190;
  return InkWell(
    onTap: () {
      //TODO - Ir para os detalhes da avaliação
      print('Carregou na avaliação: ${json['name']}');
      Navigator.pushNamed(context, '/detalhes_avaliacao', arguments: json);
    },
    child: Container(
      height: 150,
      width: larguraCard,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            width: larguraCard,
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
            width: larguraCard,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,15,0,0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Estado: ',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: json['estado'], style: TextStyle(fontWeight: FontWeight.normal, decoration: TextDecoration.underline)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  RichText(
                    text: TextSpan(
                      text: 'Data: ',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: json['data_realizacao'].toString(), style: TextStyle(fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  RichText(
                    text: TextSpan(
                      text: 'UC: ',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: json['ucId'].toString(), style: TextStyle(fontWeight: FontWeight.normal)),
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

Widget getUCWidgetFromJSON(BuildContext context, Map<String, dynamic> json) {
  double larguraCard = 190;
  return InkWell(
    onTap: () {
      //TODO - Ir para os detalhes da UC
      print('Carregou em UC: ${json['name']}');
      Navigator.pushNamed(context, '/detalhes_ucs', arguments: json);
    },
    child: Container(
      height: 150,
      width: larguraCard,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            width: larguraCard,
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
            width: larguraCard,
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

Widget getHomeAvaliacoesWidgetFromJSON(Map<String, dynamic> json, Color? corCartao){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        //TODO - Ir para os detalhes do evento
        print('Carregou em evento: ${json['name']}');
      },
      child: Container(
        decoration: BoxDecoration(
          color: corCartao,
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
              //Usado Expanded para não dar overflow
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Usado Expanded para não dar overflow
                    Expanded(
                      child: Text('${json['name']}',
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Usado Expanded para não dar overflow
                  Container(
                    width: 100,
                    child: Row(
                      children: [
                        Icon(Icons.class_outlined, size: 15,),
                        SizedBox(width: 5,),
                        //Usado Expanded para não dar overflow
                        Expanded(child: Text('${json['tipo']}', style: TextStyle(overflow: TextOverflow.ellipsis),)),
                      ],
                    ),
                  ),
                  //Usado Expanded para não dar overflow
                  Container(
                    width: 110,
                    child: Row(
                      children: [
                        Icon(Icons.insert_invitation_outlined, size: 15,),
                        SizedBox(width: 5,),
                        //Usado Expanded para não dar overflow
                        Expanded(child: Text('${json['data_realizacao']}', style: TextStyle(overflow: TextOverflow.ellipsis),)),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}