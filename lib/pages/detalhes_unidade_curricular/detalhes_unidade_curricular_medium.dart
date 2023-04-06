import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/static/colors.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar.dart';
import 'package:ontrack_backoffice/widgets/app_bar/drawer.dart';

class DetalhesUnidadeCurricularMedium extends StatefulWidget {
  const DetalhesUnidadeCurricularMedium({Key? key}) : super(key: key);

  @override
  State<DetalhesUnidadeCurricularMedium> createState() => _DetalhesUnidadeCurricularMediumState();
}

class _DetalhesUnidadeCurricularMediumState extends State<DetalhesUnidadeCurricularMedium> {

  @override
  Widget build(BuildContext context) {
    final uc = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: buildAppBar(context, 'Unidades Curriculares'),
      //drawer: buildDrawer(context),
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
