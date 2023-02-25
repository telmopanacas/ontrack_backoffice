import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/controllers/controllers.dart';
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
              child: Container(
                color: Colors.orange[100],
              ),
            ),
          ],
        )
    );
  }

  Container buildSideMenu() {
    return Container(
            width: 250,
            //color: Colors.green[100],
            child: Column(
              children: [
                // Profile
                buildProflie(),
                // Menu
                Expanded(
                    child: Container(
                      //color: Colors.green[300],
                      child: ListView(
                        children: sideMenuItems.map((itemName) => MenuItem(
                            itemName: itemName,
                            onTap: () {
                              print(itemName);
                              if(itemName == AutenticacaoPageRoute){
                                //TODO: Implementar logout
                              }
                              if(!menuController.isActive(itemName)){
                                menuController.changeActiveItemTo(itemName);
                                //TODO: Implementar navegação
                              }
                            },
                        )).toList(),
                      ),

                    )
                )
              ]
            ),
          );
  }

  Container buildProflie() {
    return Container(
      height: 130,
      //color: Colors.green[200],
      child: Row(
        children: [
          SizedBox(width: 20),
          // Avatar
          Container(
            width: 70,
            height: 70,
            //color: Colors.green[300],
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

class SideMenuItem extends StatelessWidget {
  final String itemName;
  const SideMenuItem({
    super.key, required this.itemName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (value) {
        print(itemName);
      },
      child: ListTile(
        leading: Icon(Icons.home),
        title: Text(itemName),
        hoverColor: Colors.grey.withOpacity(0.3),
      ),
    );
  }
}
