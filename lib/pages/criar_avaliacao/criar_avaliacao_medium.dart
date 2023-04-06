import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/controllers/criar_avaliacao/controllers.dart';
import 'package:ontrack_backoffice/pages/criar_avaliacao/dateInput.dart';
import 'package:ontrack_backoffice/static/colors.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar.dart';

class CriarAvaliacaoMedium extends StatefulWidget {
  const CriarAvaliacaoMedium({Key? key}) : super(key: key);

  @override
  State<CriarAvaliacaoMedium> createState() => _CriarAvaliacaoMediumState();
}


class _CriarAvaliacaoMediumState extends State<CriarAvaliacaoMedium> {
  double _larguraTextFields = 400;
  //TODO: Ir à API buscar as unidades curriculares
  List<String> _unidadesCurriculares = ['Unidade Curricular 1', 'Unidade Curricular 2', 'Unidade Curricular 3', 'Unidade Curricular 4', 'Unidade Curricular 5'];
  String _selectedUnidadeCurricular = 'Unidade Curricular 1';

  List<String> _tiposAvaliacao = ['Projeto', 'Mini-Projeto', 'Defesa', 'Teste', 'Exame', 'Apresentação'];
  @override
  Widget build(BuildContext context) {


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
                buildUnidadeCurricular(),
                SizedBox(height: 40),
                DateTimeInput(),
                SizedBox(height: 40),
                buildTipoAvaliacao(),
              ],
          )
        ),
    ),
      )
    );
  }


  Container buildUnidadeCurricular() {
    return Container(
      width: _larguraTextFields,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Unidade Curricular:', style: TextStyle(color: Colors.black, fontSize: 20)),
          SizedBox(height: 10),
          Container(

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton2(
                items: _unidadesCurriculares.map((uc) => DropdownMenuItem<String>(
                  value: uc,
                  child: Text(uc),
                )).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedUnidadeCurricular = value as String;
                  });
                },
                value: _selectedUnidadeCurricular,

                //Dimensões do dropdown
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                  width: 400,
                ),

                //Dimensões do botão
                buttonStyleData: const ButtonStyleData(
                  height: 40,
                  width: 400,
                ),

                //Dimensões de cada item do dropdown
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ),
        ],
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

  Container buildDataAvaliacao(double larguraTextFields) {
    return Container(
      width: larguraTextFields,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Data da avaliação:', style: TextStyle(color: Colors.black, fontSize: 20)),
          SizedBox(height: 10),
          TextField(

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

  Container buildTipoAvaliacao() {
    return Container(

    );
  }
}
