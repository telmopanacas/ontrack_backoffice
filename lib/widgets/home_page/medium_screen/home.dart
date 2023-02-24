import 'package:flutter/material.dart';

class MediumScreen extends StatelessWidget {
  const MediumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          children: [
            // Side Menu
            Container(
              width: 250,
              color: Colors.green[100],
              child: Column(
                children: [
                  Container(
                    height: 170,
                    color: Colors.green[200],
                  ),
                  Expanded(child: Container(color: Colors.green[300]))
                ]
              ),
            ),
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
