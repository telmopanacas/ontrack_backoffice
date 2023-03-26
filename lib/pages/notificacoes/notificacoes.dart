import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/static/colors.dart';

class NotificacoesPage extends StatelessWidget {
  const NotificacoesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: background,
        child: Center(
          child: Text('Notificacoes Page'),
        ),
      ),
    );
  }
}
