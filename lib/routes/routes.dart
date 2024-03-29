import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ontrack_backoffice/helpers/persistencia_user.dart';
import 'package:ontrack_backoffice/pages/avaliacoes/avaliacoes_layout.dart';
import 'package:ontrack_backoffice/pages/criar_avaliacao/criar_avaliacao_layout.dart';
import 'package:ontrack_backoffice/pages/detalhes_avaliacao/detalhes_avaliacao_layout.dart';
import 'package:ontrack_backoffice/pages/detalhes_unidade_curricular/detalhes_unidade_curricular_layout.dart';
import 'package:ontrack_backoffice/pages/home/home_layout.dart';
import 'package:ontrack_backoffice/pages/login/forgot_password.dart';
import 'package:ontrack_backoffice/pages/login/login_page.dart';
import 'package:ontrack_backoffice/pages/notificacoes/notificacoes_layout.dart';
import 'package:ontrack_backoffice/pages/unidades_curriculares/unidades_curriculares_layout.dart';
import 'package:ontrack_backoffice/services/api_requests.dart';

import '../pages/adicionar_unidades_curriculares/adicionar_unidades_curriculares_layout.dart';
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
      pageBuilder: (context, state) => const MaterialPage(child: HomeLayout()),
    ),

    GoRoute(
      path: '/ucs',
      pageBuilder: (context, state) => const MaterialPage(child: UnidadesCurricularesLayout()),
    ),

    GoRoute(
      path: '/ucs/:ucId',
      pageBuilder: (context, state) {

          if (state.params['ucId'] != null) {
            return MaterialPage(child: DetalhesUnidadeCurricularLayout(ucId: state.params['ucId']));
          } else {
            return const MaterialPage(child: UnidadesCurricularesLayout());
          }

      },
    ),

    GoRoute(
      path: '/avaliacoes',
      pageBuilder: (context, state) => const MaterialPage(child: AvaliacoesLayout()),
    ),

    GoRoute(
      path: '/avaliacoes/:avaliacaoId',
      pageBuilder: (context, state) {
          if (state.params['avaliacaoId'] != null) {
            return MaterialPage(child: DetalhesAvaliacaoLayout(avaliacaoId: state.params['avaliacaoId']));
          } else {
            return const MaterialPage(child: AvaliacoesLayout());
          }

      },
    ),

    GoRoute(
      path: '/notificacoes',
      pageBuilder: (context, state) => const MaterialPage(child: NotificacoesLayout()),
    ),

    GoRoute(
      path: '/criar_avaliacao',
      pageBuilder: (context, state) => const MaterialPage(child: CriarAvaliacaoLayout()),
    ),

    GoRoute(
      path: '/editar_avaliacao/:avaliacaoId',
      pageBuilder: (context, state) {

        if (state.params['avaliacaoId'] != null) {
          return MaterialPage(child: EditarAvaliacaoLayout(avaliacaoId: state.params['avaliacaoId']));
        } else {
          return const MaterialPage(child: AvaliacoesLayout());
        }

      },
    ),

    GoRoute(
      path: '/adicionar_ucs',
      pageBuilder: (context, state) => const MaterialPage(child: AdicionarUnidadesCurricularesLayout()),
    ),

  ],
  redirect: (context, state) async {

    final professorId = await getUserID();
    if (professorId == 0) { // Se não estiver logado, redireciona para a tela de login
      return '/login';
    }else if (state.location == '/login' && professorId > 0) { // Se estiver logado mas tentar acessar a tela de login, redireciona para a home
      return '/home';
    }else if(state.location != '/login'){ // Se estiver na home, verifica se o professor tem alguma UC registada
      var ucCount = await getProfessorUcCount();
      if(ucCount == 0){
        return '/adicionar_ucs';
      }else {
        return null;
      }
    }
    return null; // Permite acessar a rota atual
  },

);

