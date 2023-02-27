import 'package:flutter/material.dart';

class MediumScreen extends StatelessWidget {
  const MediumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          children: [
            // Side Menu
            SideMenu(),
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
}

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.green[100],
      child: Column(
        children: [
          // Profile
          Container(
            height: 170,
            color: Colors.green[200],
            child: Row(
              children: [

              ]
            ),
          ),
          // Menu
          Expanded(child: Container(color: Colors.green[300]))
        ]
      ),
    );
  }
}
