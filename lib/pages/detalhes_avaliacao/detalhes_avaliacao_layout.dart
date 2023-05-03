import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/helpers/responsiveness.dart';
import 'package:ontrack_backoffice/pages/detalhes_avaliacao/detalhes_avaliacao_medium.dart';
import 'package:ontrack_backoffice/pages/detalhes_avaliacao/detalhes_avaliacao_small.dart';

class DetalhesAvaliacaoLayout extends StatelessWidget {
  final String? avaliacaoId;
  const DetalhesAvaliacaoLayout({Key? key, required this.avaliacaoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        largeScreen: DetalhesAvaliacaoMedium(avaliacaoId: avaliacaoId),
        mediumScreen: DetalhesAvaliacaoMedium(avaliacaoId: avaliacaoId),
        smallScreen: DetalhesAvaliacaoSmall(avaliacaoId: avaliacaoId),
    );
  }
}
