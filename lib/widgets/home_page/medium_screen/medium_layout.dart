import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/controllers/controllers.dart';
import 'package:ontrack_backoffice/controllers/navigation_controller.dart';
import 'package:ontrack_backoffice/helpers/local_navigator.dart';
import 'package:ontrack_backoffice/routing/routes.dart';
import 'package:ontrack_backoffice/widgets/home_page/medium_screen/side_menu_item.dart';

class MediumScreen extends StatelessWidget {
  const MediumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          children: [
            // Side Menu
            buildSideMenu(),
            // Main Content
            Expanded(
              child: localNavigator()
            ),
          ],
        )
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
                buildMenu()
              ]
            ),
          );
  }

  Expanded buildMenu() {
    return Expanded(
        child: Container(

          child: ListView(
            // Vai buscar os nomes das rotas definidas em routing/routes.dart e cria um MenuItem para cada um
            children: sideMenuItems.map((itemName) => MenuItem(
                itemName: itemName,
                onTap: () {
                  print(itemName);
                  // Se o item clicado for o de logout, então faz logout e redireciona para a página de login
                  if(itemName == AutenticacaoPageRoute){
                    //TODO: Implementar logout
                  }
                  // Se o item clicado não for o de logout, então muda o item ativo para o clicado e navega para a página correspondente
                  else
                  if(!menuController.isActive(itemName)){
                    menuController.changeActiveItemTo(itemName);
                    //TODO: Implementar navegação
                    navigationController.navigateTo(itemName);
                  }
                },
            )).toList(),
          ),

        )
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
              Text('Email do Professor',style: TextStyle(fontSize: 13)),
            ],
          )
        ],
      ),
    );
  }
}

