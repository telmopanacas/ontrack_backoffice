import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/controllers/login_form_controllers.dart';
import 'package:ontrack_backoffice/pages/home/home_page.dart';
import 'package:ontrack_backoffice/routing/routes.dart';

class MediumScreen extends StatelessWidget {
  const MediumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
    );
  }

  Container buildSideMenu() {
    return Container(
            width: 250,
            child: Column(
              children: [
                // Profile
                buildProfile(),
                // Menu
              ]
            ),
          );
  }

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


