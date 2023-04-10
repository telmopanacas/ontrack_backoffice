import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/helpers/responsiveness.dart';
import 'package:ontrack_backoffice/pages/editar_avaliacao/editar_avaliacao_medium.dart';
import 'package:ontrack_backoffice/pages/editar_avaliacao/editar_avaliacao_small.dart';

class EditarAvaliacaoLayout extends StatelessWidget {
  const EditarAvaliacaoLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        largeScreen: EditarAvaliacaoMedium(),
        mediumScreen: EditarAvaliacaoMedium(),
        smallScreen: EditarAvaliacaoSmall()
    );
  }
}
