import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/helpers/responsiveness.dart';
import 'package:ontrack_backoffice/pages/unidades_curriculares/unidades_curriculares_medium.dart';
import 'package:ontrack_backoffice/pages/unidades_curriculares/unidades_curriculares_small.dart';

class UnidadesCurricularesLayout extends StatelessWidget {
  const UnidadesCurricularesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        largeScreen: UnidadesCurricularesMedium(),
        mediumScreen: UnidadesCurricularesMedium(),
        smallScreen: UnidadesCurricularesSmall(),
    );
  }
}
