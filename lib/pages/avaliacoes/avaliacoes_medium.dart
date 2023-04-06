import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/static/colors.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar.dart';
import 'package:ontrack_backoffice/widgets/app_bar/drawer.dart';

class AvaliacoesMedium extends StatelessWidget {
  const AvaliacoesMedium({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Avaliações'),
      drawer: buildDrawer(context),
      body: Container(
        color: background,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Eventos de Avaliação Page'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/criar_avaliacao');
                  },
                  child: Text('Criar Avaliação'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
