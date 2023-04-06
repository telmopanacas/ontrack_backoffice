import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar.dart';

class CriarAvaliacaoSmall extends StatelessWidget {
  const CriarAvaliacaoSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Avaliações'),
      body: Center(
        child: Text('Criar Avaliação Small'),
      ),
    );
  }
}
