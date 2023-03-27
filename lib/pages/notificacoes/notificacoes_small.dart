import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/static/colors.dart';

class NotificacoesSmall extends StatelessWidget {
  const NotificacoesSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Text('Notificacoes Small Page'),
      ),
    );
  }
}
