import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/helpers/responsiveness.dart';
import 'package:ontrack_backoffice/pages/criar_avaliacao/criar_avaliacao_medium.dart';
import 'package:ontrack_backoffice/pages/criar_avaliacao/criar_avaliacao_small.dart';

class CriarAvaliacaoLayout extends StatelessWidget {
  const CriarAvaliacaoLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        largeScreen: CriarAvaliacaoMedium(),
        mediumScreen: CriarAvaliacaoMedium(),
        smallScreen: CriarAvaliacaoSmall()
    );
  }
}
