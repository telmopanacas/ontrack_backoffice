import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/helpers/responsiveness.dart';
import 'package:ontrack_backoffice/pages/notificacoes/notificacoes_medium.dart';
import 'package:ontrack_backoffice/pages/notificacoes/notificacoes_small.dart';

class NotificacoesLayout extends StatelessWidget {
  const NotificacoesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        largeScreen: NotificacoesMedium(),
        mediumScreen: NotificacoesMedium(),
        smallScreen: NotificacoesSmall()
    );
  }
}
