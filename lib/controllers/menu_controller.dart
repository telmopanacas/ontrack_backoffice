import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontrack_backoffice/routing/routes.dart';

import '../static/colors.dart';

class ControllerMenu extends GetxController {
  static ControllerMenu instance = Get.find();
  var activeItem = 'Home'.obs;
  var hoverItem = ''.obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  changeOnHoverItem(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;
  isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case HomePageRoute:
        return _customIcon(Icons.home, itemName);
      case UnidadesCurricularesPageRoute:
        return _customIcon(Icons.list, itemName);
      case EventosDeAvaliacaoPageRoute:
        return _customIcon(Icons.event, itemName);
      case NotificacoesPageRoute:
        return _customIcon(Icons.notifications, itemName);
      case AutenticacaoPageRoute:
        return _customIcon(Icons.logout, itemName);
      default:
        return _customIcon(Icons.error, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if(isActive(itemName)) {
      return Icon(icon, color: dark, size: 22,);
    }
    else {
      return Icon(icon, color: isHovering(itemName) ? dark : lightGrey);
    }
  }
}