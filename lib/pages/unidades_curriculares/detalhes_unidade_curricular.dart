import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/controllers/controllers.dart';
import 'package:ontrack_backoffice/static/colors.dart';

class DetalhesUnidadeCurricularPage extends StatefulWidget {
  const DetalhesUnidadeCurricularPage({Key? key}) : super(key: key);

  @override
  State<DetalhesUnidadeCurricularPage> createState() => _DetalhesUnidadeCurricularPageState();
}

class _DetalhesUnidadeCurricularPageState extends State<DetalhesUnidadeCurricularPage> {
  @override
  Widget build(BuildContext context) {

    return Container(
      color: background,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Detalhes Unidades Curriculares Page'),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
               navigationController.goBack();
              },
              child: Text('Voltar'),
            )
          ],
        ),
      ),
    );
  }
}
