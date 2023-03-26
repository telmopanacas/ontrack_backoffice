import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/controllers/login_form_controllers.dart';
import 'package:ontrack_backoffice/pages/home/home_page.dart';
import 'package:ontrack_backoffice/routing/routes.dart';
import 'package:ontrack_backoffice/widgets/app_bar/drawer.dart';

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


