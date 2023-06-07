import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ontrack_backoffice/helpers/persistencia_user.dart';
import 'package:ontrack_backoffice/static/colors.dart';

AppBar buildAppBar(BuildContext context, String pageTitle) {
  return AppBar(
    iconTheme: IconThemeData(
      color: primary,
    ),
    elevation: 0,
    backgroundColor: background,
    title: TextButton(
      onPressed: (){
        GoRouter.of(context).push('/home');
      },
      child: Text('OnTrack',
        style: TextStyle(
          color: primary,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Center(
          child: Wrap(
            spacing: 15,
            children: [
              TextButton(
                onPressed: (){
                  GoRouter.of(context).push('/home');
                },
                child: Text(
                  'Home',
                  style: TextStyle(
                    color: pageTitle == 'Home' ? primary : appBarPages,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                  onPressed: (){
                    GoRouter.of(context).push('/ucs');
                  },
                  child: Text(
                    'Unidades Curriculares',
                    style: TextStyle(
                        color: pageTitle == 'Unidades Curriculares' ? primary : appBarPages,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
              ),
              TextButton(
                  onPressed: (){
                    GoRouter.of(context).push('/avaliacoes');
                  },
                  child: Text(
                    'Avaliações',
                    style: TextStyle(
                        color: pageTitle == 'Avaliações' ? primary : appBarPages,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
              ),
              TextButton(
                  onPressed: (){
                    GoRouter.of(context).push('/notificacoes');
                  },
                  child: Text(
                    'Notificações',
                    style: TextStyle(
                        color: pageTitle == 'Notificações' ? primary : appBarPages,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
              ),
              InkWell(
                onTap: () async {
                  await clearUserID();
                  GoRouter.of(context).push('/login');
                },
                child: Icon(
                  Icons.logout,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

