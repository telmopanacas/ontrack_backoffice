import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/static/colors.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar.dart';
import 'package:ontrack_backoffice/widgets/app_bar/drawer.dart';

class NotificacoesMedium extends StatelessWidget {
  const NotificacoesMedium({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Notificações'),
      drawer: buildDrawer(context),
      body: Container(
        color: background,
        child: Center(
          child: Text('Notificacoes Page'),
        ),
      ),
    );
  }
}
