import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ontrack_backoffice/models/Notificacao.dart';
import 'dart:math' as math;

import 'package:ontrack_backoffice/static/colors.dart';

Widget getNotificacaoWidget(Notificacao notificacao){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            children: [
              const Icon(CupertinoIcons.bell, color: Colors.black, size: 25,),
              const SizedBox(
                height: 24,
                child: VerticalDivider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
              Text('${notificacao.data}', style: const TextStyle(fontSize: 15),),
              const SizedBox(
                height: 24,
                child: VerticalDivider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
              Text(notificacao.mensagem, style: const TextStyle(fontSize: 15),),
            ]
          ),
        ),
      ),
    ),
  );
}

Widget getAvaliacoesWidgetFromJSON(BuildContext context, Map<String, dynamic> json) {
  double larguraCard = 190;
  String estado = "";
  String dataAvaliacaoString = json['data'];
  DateFormat inputFormat = DateFormat("dd/MM/yyyy");
  DateTime dataAvaliacao = inputFormat.parse(dataAvaliacaoString);
  if(dataAvaliacao.isAfter(DateTime.now())){
    estado = "A decorrer";
  } else {
    estado = "Terminada";
  }

  return InkWell(
    onTap: () {
      //TODO - Ir para os detalhes da avaliação
      print('Carregou na avaliação: ${json['nome']}');
      GoRouter.of(context).push('/avaliacoes/${json['id'].toString()}');
    },
    child: Container(
      height: 170,
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
                  json['nome'],
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
                        TextSpan(text: estado, style: TextStyle(fontWeight: FontWeight.normal, decoration: TextDecoration.underline)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  RichText(
                    text: TextSpan(
                      text: 'Data: ',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: json['data'].toString(), style: TextStyle(fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  RichText(
                    text: TextSpan(
                      text: 'Hora: ',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: json['hora'].toString(), style: TextStyle(fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  RichText(
                    text: TextSpan(
                      text: 'UC: ',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: json['unidadeCurricular']['nome'].toString(), style: TextStyle(fontWeight: FontWeight.normal)),
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
      print('Carregou em UC: ${json['nome']} com id: ${json['id']}');
      GoRouter.of(context).push('/ucs/${json['id']}');
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
                  json['nome'],
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
                        TextSpan(text: json['curso']['codigo'], style: TextStyle(fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  RichText(
                    text: TextSpan(
                      text: 'Ano Letivo: ',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: json['anoLetivo']['ano'].toString(), style: TextStyle(fontWeight: FontWeight.normal)),
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

Widget getHomeAvaliacoesWidgetFromJSON(BuildContext context, Map<String, dynamic> json, Color? corCartao){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        //TODO - Ir para os detalhes do evento
        print('Carregou em evento: ${json['nome']}');
        GoRouter.of(context).push('/avaliacoes/${json['id']}');
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
                      child: Text('${json['nome']}',
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
                        Expanded(child: Text('${json['tipoDeAvaliacao']}', style: TextStyle(overflow: TextOverflow.ellipsis),)),
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
                        Expanded(child: Text('${json['data']}', style: TextStyle(overflow: TextOverflow.ellipsis),)),
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