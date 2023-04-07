import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/static/colors.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar.dart';

class DetalhesAvaliacaoMedium extends StatefulWidget {
  const DetalhesAvaliacaoMedium({Key? key}) : super(key: key);

  @override
  State<DetalhesAvaliacaoMedium> createState() => _DetalhesAvaliacaoMediumState();
}

class _DetalhesAvaliacaoMediumState extends State<DetalhesAvaliacaoMedium> {
  @override
  Widget build(BuildContext context) {
    final avaliacao = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: buildAppBar(context, 'Avaliações'),
      //drawer: buildDrawer(context),
      body: Container(
        color: background,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Detalhes Avaliação Page'),
              SizedBox(height: 20,),
              Text('Nome: ${avaliacao['name']}'),
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
