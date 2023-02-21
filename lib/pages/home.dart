import 'package:flutter/material.dart';

import '../static/colors.dart';
import '../widgets/side_menu.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: background,
              child: SideMenu(),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.white,
            ),
          )

        ],
      )
    );
  }
}
