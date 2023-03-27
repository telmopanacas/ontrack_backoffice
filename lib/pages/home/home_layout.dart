import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/helpers/responsiveness.dart';
import 'package:ontrack_backoffice/pages/home/home_page_medium.dart';
import 'package:ontrack_backoffice/pages/home/home_page_small.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        largeScreen: HomePageMedium(),
        mediumScreen: HomePageMedium(),
        smallScreen: HomePageSmall(),
    );
  }
}
