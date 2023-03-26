import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/static/colors.dart';

class EventosDeAvaliacaoPage extends StatelessWidget {
  const EventosDeAvaliacaoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: background,
        child: Center(
          child: Text('Eventos de Avaliação Page'),
        ),
      ),
    );
  }
}
