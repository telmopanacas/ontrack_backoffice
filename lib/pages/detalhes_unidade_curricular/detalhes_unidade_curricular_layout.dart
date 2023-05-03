import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/helpers/responsiveness.dart';
import 'package:ontrack_backoffice/pages/detalhes_unidade_curricular/detalhes_unidade_curricular_medium.dart';
import 'package:ontrack_backoffice/pages/detalhes_unidade_curricular/detalhes_unidade_curriular_small.dart';

class DetalhesUnidadeCurricularLayout extends StatelessWidget {
  final String? ucId;
  const DetalhesUnidadeCurricularLayout({Key? key, this.ucId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: DetalhesUnidadeCurricularMedium(ucId: ucId),
      mediumScreen: DetalhesUnidadeCurricularMedium(ucId: ucId),
      smallScreen: DetalhesUnidadeCurricularSmall(ucId: ucId),
    );
  }
}
