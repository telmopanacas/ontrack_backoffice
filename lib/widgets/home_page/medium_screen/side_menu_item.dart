import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrack_backoffice/controllers/controllers.dart';

import '../../../static/colors.dart';

class MenuItem extends StatelessWidget {
  final String itemName;
  final Function()? onTap;
  const MenuItem({Key? key, required this.itemName, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      // value é true quando o rato está sobre o item e false quando não está
      onHover: (value) {
        // Se o rato estiver sobre o item, então muda o item em hover para o item em questão
        value ? menuController.changeOnHoverItem(itemName) : menuController.changeOnHoverItem('');
      },
      child: Obx(() => Container(
        // Se o item estiver em hover, então muda a cor de fundo para cinzento claro
        color: menuController.isHovering(itemName) ? lightGrey.withOpacity(0.1) : Colors.transparent,
        child: Row(
          children: [
            Visibility(
              // Se o item estiver em hover ou ativo, então mostra a barra lateral esquerda
              visible: menuController.isHovering(itemName) || menuController.isActive(itemName),
              child: Container(
                width: 6,
                height: 40,
                color: dark,
              ),
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
            ),
            SizedBox(width: _width / 80),
            // Icone do item
            Padding(
              padding: EdgeInsets.all(16),
              child: menuController.returnIconFor(itemName),
            ),
            // Se o item estiver ativo, então mostra o nome do item em negrito
            if(menuController.isActive(itemName))
              Text(itemName, style: TextStyle(color: dark, fontWeight: FontWeight.bold,),)
            else
              Text(itemName, style: TextStyle(color: menuController.isHovering(itemName) ? dark : lightGrey),)
          ]
        ),

      )),
    );
  }
}
