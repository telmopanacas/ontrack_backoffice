import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ontrack_backoffice/controllers/login/login_form_controllers.dart';
import 'package:ontrack_backoffice/services/api_login.dart';
import 'package:ontrack_backoffice/static/colors.dart';

import '../../helpers/persistencia_user.dart';

List<String> pages = ['Home', 'Unidades Curriculares', 'Avaliações', 'Sair'];

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

Widget buildProfile() {
  return DrawerProfile();
}

class DrawerProfile extends StatefulWidget {
  const DrawerProfile({
    super.key,
  });

  @override
  State<DrawerProfile> createState() => _DrawerProfileState();
}


class _DrawerProfileState extends State<DrawerProfile> {
  String emailProfessor = "p1234@ulusofona.pt";
  String nomeProfessor = "Nome do Professor";

  @override
  Widget build(BuildContext context) {
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
                backgroundImage: Image.asset('assets/images/default_pfp.png').image,
              backgroundColor: Colors.transparent,
            ),
          ),
          SizedBox(width: 20),
          // Name & Email
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bem-Vindo,', style: TextStyle(fontSize: 15)),
              Text(nomeProfessor,style: TextStyle(fontSize: 13)),
              Text(emailProfessor,style: TextStyle(fontSize: 13)),
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getUserEmail().then((value) => setState(() {
      emailProfessor = value;
    }));
    getUserName().then((value) => setState(() {
      nomeProfessor = value;
    }));
  }
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