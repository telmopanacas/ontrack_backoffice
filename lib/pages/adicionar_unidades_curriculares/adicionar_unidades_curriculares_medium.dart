import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ontrack_backoffice/models/UnidadeCurricular.dart';
import 'package:ontrack_backoffice/services/api_requests.dart';
import 'package:ontrack_backoffice/widgets/api_data_widgets/api_data_helper.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar_add_ucs.dart';
import 'dart:math' as math;

import '../../static/colors.dart';

List<int> ucs = [];

class AdicionarUnidadesCurricularesMedium extends StatefulWidget {
  const AdicionarUnidadesCurricularesMedium({Key? key}) : super(key: key);

  @override
  State<AdicionarUnidadesCurricularesMedium> createState() => _AdicionarUnidadesCurricularesMediumState();
}

class _AdicionarUnidadesCurricularesMediumState extends State<AdicionarUnidadesCurricularesMedium> {

  Map<String, int> _cursos = {
    "Curso 1": 0,
  };
  //cursos.keys
  String _cursoSelecionado = "Curso 1";

  bool _1anoIsExpanded = true;
  bool _2anoIsExpanded = true;
  bool _3anoIsExpanded = true;


  @override
  void initState() {
    super.initState();
    getCursos().then((value) => {
      setState(() {
        _cursos = value;
        print(_cursos);
        _cursoSelecionado = _cursos.keys.first;
      })
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: buildAppBarAddUCs(context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        color: background,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: buildCursosDropdown(context),
              ),
              const SizedBox(height: 20),
              build1AnoUCs(context),
              const SizedBox(height: 20),
              build2AnoUCs(context),
              const SizedBox(height: 20),
              build3AnoUCs(context),
              const SizedBox(height: 50),
              buildBotaoSubmeter(context),
              const SizedBox(height: 30),
            ],
          ),
        ),
      )
    );
  }

  ElevatedButton buildBotaoSubmeter(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if(ucs.isEmpty){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(child: Text('Selecione pelo menos 1 Unidade Curricular!', style: TextStyle(fontSize: 20))),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          addUCsProfessor(ucs).then((value) {
            if(value){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Center(child: Text('Submetido com sucesso', style: TextStyle(fontSize: 20))),
                  backgroundColor: Colors.green,
                ),
              );
              ucs.clear();
              GoRouter.of(context).push('/home');
            }else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Center(child: Text('Erro ao submeter', style: TextStyle(fontSize: 20))),
                  backgroundColor: Colors.red,
                ),
              );
            }
          });

        }
      },
      child: Text('Submeter'),
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(200, 50),
      ),
    );
  }

  ExpansionTile build1AnoUCs(BuildContext context) {
    return ExpansionTile(
      trailing: SizedBox.shrink(),
      onExpansionChanged: (value) {
        setState(() {
          _1anoIsExpanded = !_1anoIsExpanded;
        });
      },
      shape: Border(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            '1º Ano',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 5),
          _1anoIsExpanded ? Icon(Icons.keyboard_arrow_up, color: primary,) : Icon(Icons.keyboard_arrow_down, color: primary,),
        ],
      ),
      textColor: Colors.black,
      initiallyExpanded: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: buildUCsContainer(context, _cursos[_cursoSelecionado]!, 1),
        ),
      ],

    );
  }

  ExpansionTile build2AnoUCs(BuildContext context) {
    return ExpansionTile(
      trailing: SizedBox.shrink(),
      onExpansionChanged: (value) {
        setState(() {
          _2anoIsExpanded = !_2anoIsExpanded;
        });
      },
      shape: Border(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            '2º Ano',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 5),
          _2anoIsExpanded ? Icon(Icons.keyboard_arrow_up, color: primary,) : Icon(Icons.keyboard_arrow_down, color: primary,),
        ],
      ),
      textColor: Colors.black,
      initiallyExpanded: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: buildUCsContainer(context, _cursos[_cursoSelecionado]!, 2),
        ),
      ],

    );
  }

  ExpansionTile build3AnoUCs(BuildContext context) {
    return ExpansionTile(
      trailing: SizedBox.shrink(),
      onExpansionChanged: (value) {
        setState(() {
          _3anoIsExpanded = !_3anoIsExpanded;
        });
      },
      shape: Border(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            '3º Ano',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 5),
          _3anoIsExpanded ? Icon(Icons.keyboard_arrow_up, color: primary,) : Icon(Icons.keyboard_arrow_down, color: primary,),
        ],
      ),
      textColor: Colors.black,
      initiallyExpanded: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: buildUCsContainer(context, _cursos[_cursoSelecionado]!, 3),
        ),
      ],

    );
  }

  Widget buildCursosDropdown(BuildContext context) {
    return Container(
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Curso: ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10,),
            buildCursoButao(),
          ],
        )
    );
  }

  DropdownButton2<String> buildCursoButao() {
    return DropdownButton2(
      isExpanded: true,
      items: _cursos.keys.map((curso) => DropdownMenuItem<String>(
        value: curso,
        child: Text(curso),
      )).toList(),
      value: _cursoSelecionado,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 17,
        overflow: TextOverflow.clip,
      ),
      onChanged: (value) {
        setState(() {
          _cursoSelecionado = value!;
        });
      },

      //Dimensões do dropdown
      dropdownStyleData: const DropdownStyleData(
        maxHeight: 250,
        width: 330,
      ),

      //Dimensões do botão
      buttonStyleData: const ButtonStyleData(
        height: 60,
        width: 330,

      ),

      //Dimensões de cada item do dropdown
      menuItemStyleData: const MenuItemStyleData(
        height: 60,
      ),
    );
  }

  Container buildUCsContainer(BuildContext context, int cursoId, int ano) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 200,
      ),
      child: FutureBuilder(
        future: getUCsByCursoEAno(context, cursoId, ano),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                spacing: 15,
                runSpacing: 15,
                alignment: WrapAlignment.start,
                children: snapshot.data as List<Widget>,
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// create a statefull widget that is a checkbox
class UCWidget extends StatefulWidget {
  final UnidadeCurricular unidadeCurricular;

  const UCWidget({super.key, required this.unidadeCurricular});
  @override
  UCWidgetState createState() => UCWidgetState();
}

class UCWidgetState extends State<UCWidget> {


  @override
  Widget build(BuildContext context) {
    bool isSelected = ucs.contains(widget.unidadeCurricular.id);
    return InkWell(
      onTap: () {
        setState(() {
          if(isSelected) {
            ucs.remove(widget.unidadeCurricular.id);
          } else {
            ucs.add(widget.unidadeCurricular.id);
          }
        });
      },
      child: Container(
        //
        width: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 0),
                    child: Text(
                      widget.unidadeCurricular.nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Semestre: ${widget.unidadeCurricular.semestre}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Checkbox(
                value: isSelected,
                onChanged: (value) {
                  setState(() {
                    if(isSelected) {
                      ucs.remove(widget.unidadeCurricular.id);
                    } else {
                      ucs.add(widget.unidadeCurricular.id);
                    }
                  });
                },
                activeColor: primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

