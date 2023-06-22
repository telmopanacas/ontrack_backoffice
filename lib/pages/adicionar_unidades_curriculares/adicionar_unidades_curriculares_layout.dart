import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/helpers/responsiveness.dart';

import 'adicionar_unidades_curriculares_medium.dart';
import 'adicionar_unidades_curriculares_small.dart';

class AdicionarUnidadesCurricularesLayout extends StatelessWidget {
  const AdicionarUnidadesCurricularesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        largeScreen: AdicionarUnidadesCurricularesMedium(),
        mediumScreen: AdicionarUnidadesCurricularesMedium(),
        smallScreen: AdicionarUnidadesCurricularesSmall(),
    );
  }
}