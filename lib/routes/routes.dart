import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ontrack_backoffice/helpers/user_helper.dart';
import 'package:ontrack_backoffice/pages/avaliacoes/avaliacoes_layout.dart';
import 'package:ontrack_backoffice/pages/criar_avaliacao/criar_avaliacao_layout.dart';
import 'package:ontrack_backoffice/pages/detalhes_avaliacao/detalhes_avaliacao_layout.dart';
import 'package:ontrack_backoffice/pages/detalhes_unidade_curricular/detalhes_unidade_curricular_layout.dart';
import 'package:ontrack_backoffice/pages/home/home_layout.dart';
import 'package:ontrack_backoffice/pages/login/forgot_password.dart';
import 'package:ontrack_backoffice/pages/login/login_page.dart';
import 'package:ontrack_backoffice/pages/notificacoes/notificacoes_layout.dart';
import 'package:ontrack_backoffice/pages/unidades_curriculares/unidades_curriculares_layout.dart';

import '../pages/editar_avaliacao/editar_avaliacao_layout.dart';



final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
    ),

    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
    ),

    GoRoute(
      path: '/forgot_password',
      pageBuilder: (context, state) => const MaterialPage(child: ForgotPasswordPage()),
    ),

    GoRoute(
      path: '/home',
      pageBuilder: (context, state){

        if(professor.id <= 0) {
          return const MaterialPage(child: LoginPage());
        } else {
          return const MaterialPage(child: HomeLayout());
        }

      }
    ),

    GoRoute(
      path: '/ucs',
      pageBuilder: (context, state) {

        if(professor.id <= 0) {
          return const MaterialPage(child: LoginPage());
        } else {
          return const MaterialPage(child: UnidadesCurricularesLayout());
        }
      }
    ),

    GoRoute(
      path: '/ucs/:ucId',
      pageBuilder: (context, state) {

        if(professor.id <= 0) {
          return const MaterialPage(child: LoginPage());
        } else {

          if (state.params['ucId'] != null) {
            return MaterialPage(child: DetalhesUnidadeCurricularLayout(ucId: state.params['ucId']));
          } else {
            return const MaterialPage(child: UnidadesCurricularesLayout());
          }

        }
      },
    ),

    GoRoute(
      path: '/avaliacoes',
      pageBuilder: (context, state) {

          if(professor.id <= 0) {
            return const MaterialPage(child: LoginPage());
          } else {
            return const MaterialPage(child: AvaliacoesLayout());
          }

      }
    ),

    GoRoute(
      path: '/avaliacoes/:avaliacaoId',
      pageBuilder: (context, state) {

        if(professor.id <= 0) {
          return const MaterialPage(child: LoginPage());
        } else {
          if (state.params['avaliacaoId'] != null) {
            return MaterialPage(child: DetalhesAvaliacaoLayout(avaliacaoId: state.params['avaliacaoId']));
          } else {
            return const MaterialPage(child: AvaliacoesLayout());
          }
        }

      },
    ),

    GoRoute(
      path: '/notificacoes',
      pageBuilder: (context, state) {

          if(professor.id <= 0) {
            return const MaterialPage(child: LoginPage());
          } else {
            return const MaterialPage(child: NotificacoesLayout());
          }

      }
    ),

    GoRoute(
      path: '/criar_avaliacao',
      pageBuilder: (context, state) {

            if(professor.id <= 0) {
              return const MaterialPage(child: LoginPage());
            } else {
              return const MaterialPage(child: CriarAvaliacaoLayout());
            }

      }
    ),

    GoRoute(
      path: '/editar_avaliacao/:avaliacaoId',
      pageBuilder: (context, state) {

        if (state.params['avaliacaoId'] != null) {
          return MaterialPage(child: DetalhesAvaliacaoLayout(avaliacaoId: state.params['avaliacaoId']));
        } else {
          if (state.params['avaliacaoId'] != null) {
            return MaterialPage(child: EditarAvaliacaoLayout(avaliacaoId: state.params['avaliacaoId']));
          } else {
            return const MaterialPage(child: AvaliacoesLayout());
          }
        }
      },
    ),


  ]
);

/*
routes: {
        '/': (context) => LoginPage(),
        '/login': (context) => LoginPage(),
        '/forgot_password': (context) => ForgotPasswordPage(),
        '/home': (context) => HomeLayout(),
        '/ucs': (context) => UnidadesCurricularesLayout(),
        '/avaliacoes': (context) => AvaliacoesLayout(),
        '/notificacoes': (context) => NotificacoesLayout(),
        '/detalhes_ucs': (context) => DetalhesUnidadeCurricularLayout(),
        '/criar_avaliacao': (context) => CriarAvaliacaoLayout(),
        '/detalhes_avaliacao': (context) => DetalhesAvaliacaoLayout(),
        '/editar_avaliacao' : (context) => EditarAvaliacaoLayout(),
      },
 */