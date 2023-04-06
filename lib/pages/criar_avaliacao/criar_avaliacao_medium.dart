import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/controllers/criar_avaliacao/controllers.dart';
import 'package:ontrack_backoffice/static/colors.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar.dart';

class CriarAvaliacaoMedium extends StatelessWidget {
  const CriarAvaliacaoMedium({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _larguraTextFields = 400;

    return Scaffold(
      appBar: buildAppBar(context, 'Avaliações'),
      body: Container(
        color: background,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Criar Avaliação',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 40),

                //Nome da avaliação
                buildNomeAvaliacao(_larguraTextFields),
                SizedBox(height: 40),
                Container(
                  width: _larguraTextFields,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Unidade Curricular:', style: TextStyle(color: Colors.black, fontSize: 20)),
                      SizedBox(height: 10),

                    ],
                  )
                )
              ],
          )
        ),
    ),
      )
    );
  }

  Container buildNomeAvaliacao(double _larguraTextFields) {
    return Container(
      width: _larguraTextFields,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nome da avaliação:', style: TextStyle(color: Colors.black, fontSize: 20)),
          SizedBox(height: 10),
          TextField(
            controller: nomeAvaliacaoController,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.black, fontSize: 20),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: primary, width: 2.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
