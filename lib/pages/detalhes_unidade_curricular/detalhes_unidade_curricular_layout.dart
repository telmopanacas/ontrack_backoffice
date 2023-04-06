import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/helpers/responsiveness.dart';
import 'package:ontrack_backoffice/pages/detalhes_unidade_curricular/detalhes_unidade_curricular_medium.dart';
import 'package:ontrack_backoffice/pages/detalhes_unidade_curricular/detalhes_unidade_curriular_small.dart';

class DetalhesUnidadeCurricularLayout extends StatelessWidget {
  const DetalhesUnidadeCurricularLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: DetalhesUnidadeCurricularMedium(),
      mediumScreen: DetalhesUnidadeCurricularMedium(),
      smallScreen: DetalhesUnidadeCurricularSmall(),
    );
  }
}
