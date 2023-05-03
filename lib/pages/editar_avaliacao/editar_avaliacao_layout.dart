import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/helpers/responsiveness.dart';
import 'package:ontrack_backoffice/pages/editar_avaliacao/editar_avaliacao_medium.dart';
import 'package:ontrack_backoffice/pages/editar_avaliacao/editar_avaliacao_small.dart';

class EditarAvaliacaoLayout extends StatelessWidget {
  final String? avaliacaoId;
  const EditarAvaliacaoLayout({Key? key, this.avaliacaoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        largeScreen: EditarAvaliacaoMedium(avaliacaoId: avaliacaoId,),
        mediumScreen: EditarAvaliacaoMedium(avaliacaoId: avaliacaoId),
        smallScreen: EditarAvaliacaoSmall(avaliacaoId: avaliacaoId)
    );
  }
}
