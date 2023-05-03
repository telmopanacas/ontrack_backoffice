import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ontrack_backoffice/controllers/criar_avaliacao/controllers.dart';
import 'package:ontrack_backoffice/pages/criar_avaliacao/dateInput.dart';
import 'package:ontrack_backoffice/services/api_requests.dart';
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
  List<String> _unidadesCurriculares = [
    'Unidade Curricular 1',
    'Unidade Curricular 2',
    'Unidade Curricular 3',
    'Unidade Curricular 4',
    'Unidade Curricular 5'
  ];
  String _selectedUnidadeCurricular = 'Unidade Curricular 1';

  //TODO: Ir à API buscar os tipos de avaliação
  List<String> _tiposAvaliacao = [
    'Projeto',
    'Mini-Projeto',
    'Defesa',
    'Teste',
    'Mini-Teste',
    'Exame',
    'Apresentação'
  ];
  String _selectedTipoAvaliacao = 'Projeto';

  //TODO: Ir à API buscar os métodos de entrega
  List<String> _metodosEntrega = ['Moodle', 'Email', 'Presencial'];
  String _selectedMetodoEntrega = 'Moodle';

  @override
  Widget build(BuildContext context) {
    unidadeCurricularController.text = _selectedUnidadeCurricular;
    tipoAvaliacaoController.text = _selectedTipoAvaliacao;
    metodoEntregaController.text = _selectedMetodoEntrega;


    return Scaffold(
        appBar: buildAppBar(context, 'Avaliações'),
        body: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery
                .of(context)
                .size
                .height,
          ),
          color: background,
          child: SingleChildScrollView(
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
                      Container(
                        alignment: Alignment.centerLeft,
                        width: _larguraTextFields,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: '*',
                                  style: TextStyle(color: Colors.red)),
                              TextSpan(text: ' Campos obrigatórios'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      //Nome da avaliação
                      buildNomeAvaliacao(),
                      SizedBox(height: 40),
                      buildTipoAvaliacao(),
                      SizedBox(height: 40,),
                      buildUnidadeCurricular(),
                      SizedBox(height: 40),
                      DateTimeInput(),
                      SizedBox(height: 40),
                      buildMetodoEntrega(),
                      SizedBox(height: 40),
                      buildDescricaoAvaliacao(),
                      SizedBox(height: 40),
                      buildBotaoCriarAvaliacao(context),
                    ],
                  )
              ),
            ),
          ),
        )
    );
  }

  Container buildNomeAvaliacao() {
    return Container(
      width: _larguraTextFields,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              children: <TextSpan>[
                TextSpan(text: 'Nome da avaliação: '),
                TextSpan(text: '*', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: nomeAvaliacaoController,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.black, fontSize: 20),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primary, width: 2.0),
              ),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Container buildTipoAvaliacao() {
    return Container(
      width: _larguraTextFields,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              children: <TextSpan>[
                TextSpan(text: 'Tipo de avaliação: '),
                TextSpan(text: '*', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton2(
                items: _tiposAvaliacao.map((ta) =>
                    DropdownMenuItem<String>(
                      value: ta,
                      child: Text(ta),
                    )).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTipoAvaliacao = value as String;
                    tipoAvaliacaoController.text = _selectedTipoAvaliacao;
                  });
                },
                value: _selectedTipoAvaliacao,

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
      ),
    );
  }

  Container buildUnidadeCurricular() {
    return Container(
        width: _larguraTextFields,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                children: <TextSpan>[
                  TextSpan(text: 'Unidade Curricular: '),
                  TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton2(
                  items: _unidadesCurriculares.map((uc) =>
                      DropdownMenuItem<String>(
                        value: uc,
                        child: Text(uc),
                      )).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedUnidadeCurricular = value as String;
                      unidadeCurricularController.text =
                          _selectedUnidadeCurricular;
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

  Container buildMetodoEntrega() {
    return Container(
        width: _larguraTextFields,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                children: <TextSpan>[
                  TextSpan(text: 'Método de entrega: '),
                  TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton2(
                  items: _metodosEntrega.map((me) =>
                      DropdownMenuItem<String>(
                        value: me,
                        child: Text(me),
                      )).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedMetodoEntrega = value as String;
                      metodoEntregaController.text = _selectedMetodoEntrega;
                    });
                  },
                  value: _selectedMetodoEntrega,

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

  Container buildDescricaoAvaliacao() {
    return Container(
        width: _larguraTextFields,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Descrição da avaliação (opcional):',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              SizedBox(height: 10),
              TextField(
                maxLines: null,
                maxLength: 400,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Descrição',
                ),
                controller: descricaoController,
                keyboardType: TextInputType.text,
              ),
            ]
        )
    );
  }

  Container buildBotaoCriarAvaliacao(BuildContext context) {
    return Container(
      width: _larguraTextFields,
      child: ElevatedButton(
        onPressed: () async {
          if (nomeAvaliacaoController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('O nome da avaliação não pode estar vazio!'),
              backgroundColor: Colors.red,
            ));
          } else if (metodoEntregaController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('O método de entrega não pode estar vazio!'),
              backgroundColor: Colors.red,
            ));
          } else if (tipoAvaliacaoController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('O tipo de avaliação não pode estar vazio!'),
              backgroundColor: Colors.red,
            ));
          } else {
            //TODO: Enviar para a base de dados

            await createAvaliacao(toJson());

            //Clear dos text fields
            nomeAvaliacaoController.clear();
            unidadeCurricularController.clear();
            metodoEntregaController.clear();
            descricaoController.clear();
            tipoAvaliacaoController.clear();
            dataController.clear();

            GoRouter.of(context).pop();
          }
        },
        child: Text('Criar avaliação',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    final data = dataController.text.split(" ")[0];
    final hora = dataController.text.split(" ")[1];

    return {
      'name': nomeAvaliacaoController.text,
      'data_realizacao': data,
      'hora_realizacao': hora,
      'estado': 'A decorrer',
      'metodo_entrega': metodoEntregaController.text,
      'tipo': tipoAvaliacaoController.text,
      //Por agora está o nome da UC, mas depois será o id
      'ucId': unidadeCurricularController.text,
      'descricao': descricaoController.text,
    };
  }
}
