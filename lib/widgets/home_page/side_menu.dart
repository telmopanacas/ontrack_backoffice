import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ontrack_backoffice/controllers/login_form_controllers.dart';

import '../custom_text.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Profile()
        ),
        Divider( color: Colors.black,thickness: 0.5,),
        Expanded(
          flex: 3,
          child: Menu()
        ),
      ],
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 10),
          MenuItem(text: 'Home', icon: 'square'),
          SizedBox(height: 10),
          MenuItem(text: 'Unidades Curriculares', icon: 'square'),
          SizedBox(height: 10),
          MenuItem(text: 'Eventos de Avaliação', icon: 'square'),
          SizedBox(height: 10),
          MenuItem(text: 'Notificações', icon: 'square'),
        ]
      ),
      );
  }
}

class MenuItem extends StatelessWidget {
  final String text;
  final String icon;

  const MenuItem({
    super.key, required this.text, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/square.svg',
            height: 25,
          ),
          CustomText(text: text, size: 15, color: Colors.black, weight:FontWeight.normal, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/letter-p.png'),
                radius: 50.0,
            ),
          ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(alignment: Alignment.centerLeft, child: CustomText(text: 'Bem-Vindo,', size: 20, color: Colors.black, weight:FontWeight.normal, textAlign: TextAlign.left)),
              SizedBox(height: 10),
              Align(alignment: Alignment.centerLeft, child: CustomText(text: 'Nome do Professor', size: 15, color: Colors.black, weight:FontWeight.normal, textAlign: TextAlign.left)),
              SizedBox(height: 5),
              Align(alignment: Alignment.centerLeft, child: CustomText(text: emailController.text.isNotEmpty ? emailController.text : 'problema com email', size: 10, color: Colors.black, weight:FontWeight.normal, textAlign: TextAlign.left)),
            ]
          )
        ),

      ],
    );
  }
}
