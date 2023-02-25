import 'package:flutter/material.dart';

import '../helpers/responsiveness.dart';
import '../static/colors.dart';
import '../widgets/home_page/large_screen/home.dart';
import '../widgets/home_page/medium_screen/home.dart';
import '../widgets/home_page/small_screen/home.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: LargeScreen(),
      mediumScreen: MediumScreen(),
      smallScreen: SmallScreen(),
    );
  }
}
