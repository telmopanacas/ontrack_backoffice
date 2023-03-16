import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/pages/home/home_test_mockapi.dart';
import 'package:ontrack_backoffice/routing/routes.dart';
import 'package:ontrack_backoffice/widgets/login_page/login_form.dart';

import '../pages/eventos_avaliacao/eventos_avaliacao.dart';
import '../pages/home/home.dart';
import '../pages/notificacoes/notificacoes.dart';
import '../pages/unidades_curriculares/unidades_curriculares.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch(settings.name) {
    case HomePageRoute:
      //TODO: Mudar para HomePage
      return _getPageRoute(HomePageAPI());
    case UnidadesCurricularesPageRoute:
      return _getPageRoute(UnidadesCurricularesPage());
    case EventosDeAvaliacaoPageRoute:
      return _getPageRoute(EventosDeAvaliacaoPage());
    case NotificacoesPageRoute:
      return _getPageRoute(NotificacoesPage());
    default:
      return _getPageRoute(HomePage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(
    builder: (context) => child,
  );
}