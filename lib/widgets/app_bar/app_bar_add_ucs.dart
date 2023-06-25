import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ontrack_backoffice/helpers/persistencia_user.dart';
import 'package:ontrack_backoffice/static/colors.dart';

AppBar buildAppBarAddUCs(BuildContext context) {
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
              InkWell(
                onTap: () async {
                  await clearUserID();
                  await clearUserEmail();
                  GoRouter.of(context).push('/login');
                },
                child: const Icon(
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