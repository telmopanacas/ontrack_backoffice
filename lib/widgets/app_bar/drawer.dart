import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ontrack_backoffice/controllers/login/login_form_controllers.dart';
import 'package:ontrack_backoffice/static/colors.dart';

import '../../helpers/persistencia_user.dart';

List<String> pages = ['Home', 'Unidades Curriculares', 'Avaliações', 'Notificações', 'Sair'];

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: buildProfile(),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
        ...pages.map((page) => buildDrawerItem(page, context)).toList(),
      ],
    ),
  );
}

Container buildProfile() {
  return Container(
    height: 130,
    child: Row(
      children: [
        SizedBox(width: 20),
        // Avatar
        Container(
          width: 70,
          height: 70,
          child: CircleAvatar(
              backgroundImage: Image.asset('assets/images/chun-li.png').image
          ),
        ),
        SizedBox(width: 20),
        // Name & Email
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bem-Vindo,', style: TextStyle(fontSize: 15)),
            Text('Nome do Professor',style: TextStyle(fontSize: 13)),
            Text('${emailController.text.isNotEmpty ? emailController.text : 'Email do professor' }',style: TextStyle(fontSize: 13)),
          ],
        )
      ],
    ),
  );
}

ListTile buildDrawerItem(String page, BuildContext context) {
  return ListTile(
    leading: getIcon(page),
    title: Text(page),
    onTap: () async {
      switch (page) {
        case 'Home':
          GoRouter.of(context).push('/home');
          break;
        case 'Unidades Curriculares':
          GoRouter.of(context).push('/ucs');
          break;
        case 'Avaliações':
          GoRouter.of(context).push('/avaliacoes');
          break;
        case 'Notificações':
          GoRouter.of(context).push('/notificacoes');
          break;
        case 'Sair':
          await clearUserID();
          GoRouter.of(context).push('/login');
          break;
        default:
          GoRouter.of(context).push('/home');
      }
    },
  );
}

Icon getIcon(String page) {
  switch (page) {
    case 'Home':
      return Icon(Icons.home, color: primary);
    case 'Unidades Curriculares':
      return Icon(Icons.book, color: primary,);
    case 'Avaliações':
      return Icon(Icons.assignment, color: primary,);
    case 'Notificações':
      return Icon(Icons.notifications, color: primary,);
    case 'Sair':
      return Icon(Icons.logout, color: primary,);
    default:
      return Icon(Icons.home, color: primary);
  }
}