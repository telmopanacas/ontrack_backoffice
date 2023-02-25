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
      onHover: (value) {
        value ? menuController.changeOnHoverItem(itemName) : menuController.changeOnHoverItem('');
      },
      child: Obx(() => Container(
        color: menuController.isHovering(itemName) ? lightGrey.withOpacity(0.1) : Colors.transparent,
        child: Row(
          children: [
            Visibility(
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
            Padding(
              padding: EdgeInsets.all(16),
              child: menuController.returnIconFor(itemName),
            ),

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
