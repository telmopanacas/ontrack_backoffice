import 'package:flutter/material.dart';

import '../helpers/responsiveness.dart';
import '../static/colors.dart';
import '../widgets/home_page/large_screen/large_layout.dart';
import '../widgets/home_page/medium_screen/medium_layout.dart';
import '../widgets/home_page/small_screen/small_layout.dart';

class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: MediumScreen(),
      mediumScreen: MediumScreen(),
      smallScreen: SmallScreen(),
    );
  }
}
