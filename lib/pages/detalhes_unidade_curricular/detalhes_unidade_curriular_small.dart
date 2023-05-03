import 'package:flutter/material.dart';

class DetalhesUnidadeCurricularSmall extends StatelessWidget {
  final String? ucId;
  const DetalhesUnidadeCurricularSmall({Key? key, this.ucId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Center(
            child: Text('Detalhes Unidade Curricular Small Screen'),
          ),
        ));
  }
}
