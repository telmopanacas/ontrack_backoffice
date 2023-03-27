import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/helpers/responsiveness.dart';
import 'package:ontrack_backoffice/pages/avaliacoes/avaliacoes_medium.dart';
import 'package:ontrack_backoffice/pages/avaliacoes/avaliacoes_small.dart';

class AvaliacoesLayout extends StatelessWidget {
  const AvaliacoesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        largeScreen: AvaliacoesMedium(),
        mediumScreen: AvaliacoesMedium(),
        smallScreen: AvaliacoesSmall(),
    );
  }
}
