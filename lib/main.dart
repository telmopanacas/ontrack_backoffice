import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ontrack_backoffice/pages/avaliacoes/avaliacoes_layout.dart';
import 'package:ontrack_backoffice/pages/criar_avaliacao/criar_avaliacao_layout.dart';
import 'package:ontrack_backoffice/pages/detalhes_avaliacao/detalhes_avaliacao_layout.dart';
import 'package:ontrack_backoffice/pages/detalhes_unidade_curricular/detalhes_unidade_curricular_layout.dart';
import 'package:ontrack_backoffice/pages/editar_avaliacao/editar_avaliacao_layout.dart';
import 'package:ontrack_backoffice/pages/home/home_layout.dart';
import 'package:ontrack_backoffice/pages/login/forgot_password.dart';

import 'package:ontrack_backoffice/pages/login/login_page.dart';
import 'package:ontrack_backoffice/pages/notificacoes/notificacoes_layout.dart';
import 'package:ontrack_backoffice/pages/notificacoes/notificacoes_medium.dart';
import 'package:ontrack_backoffice/pages/detalhes_unidade_curricular/detalhes_unidade_curricular_medium.dart';
import 'package:ontrack_backoffice/pages/unidades_curriculares/unidades_curriculares_layout.dart';
import 'package:ontrack_backoffice/routes/routes.dart';
import 'package:ontrack_backoffice/static/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'OnTrack Backoffice',
      theme: ThemeData(
        primarySwatch: primarySwatch,
        scaffoldBackgroundColor: Colors.white,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('pt'), // Spanish
      ],
      routerDelegate: routes.routerDelegate,
      routeInformationParser: routes.routeInformationParser,
      routeInformationProvider: routes.routeInformationProvider,
    );
  }
}
