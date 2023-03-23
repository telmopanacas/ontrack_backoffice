import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/static/colors.dart';

class DetalhesUnidadeCurricular extends StatefulWidget {
  const DetalhesUnidadeCurricular({Key? key}) : super(key: key);

  @override
  State<DetalhesUnidadeCurricular> createState() => _DetalhesUnidadeCurricularState();
}

class _DetalhesUnidadeCurricularState extends State<DetalhesUnidadeCurricular> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      child: Center(
        child: Text('Detalhes Unidades Curriculares Page'),
      ),
    );
  }
}
