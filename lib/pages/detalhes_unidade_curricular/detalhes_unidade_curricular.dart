import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/static/colors.dart';

class DetalhesUnidadeCurricularPage extends StatefulWidget {
  const DetalhesUnidadeCurricularPage({Key? key}) : super(key: key);

  @override
  State<DetalhesUnidadeCurricularPage> createState() => _DetalhesUnidadeCurricularPageState();
}

class _DetalhesUnidadeCurricularPageState extends State<DetalhesUnidadeCurricularPage> {

  @override
  Widget build(BuildContext context) {
    final uc = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      body: Container(
        color: background,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Detalhes Unidades Curriculares Page'),
              SizedBox(height: 20,),
              Text('Nome: ${uc['name']}'),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                 //TODO: Fazer voltar para tras
                  Navigator.pop(context);
                },
                child: Text('Voltar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
