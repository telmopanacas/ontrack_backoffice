import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/services/api_requests.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar_add_ucs.dart';

import '../../static/colors.dart';

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
  String _cursoSelecionado = "";


  @override
  void initState() {
    super.initState();
    getCursos().then((value) => {
      setState(() {
        _cursos = value;
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
                const Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 20),
                  child: Center(
                  child: Text(
                  "Unidades Curriculares selecionadas",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
              ),
                ),
              buildUCsSelecionadasContainer(context),
            ],
          ),
        ),
      )
    );
  }

  Widget buildUCsSelecionadasContainer(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width*0.8,
      constraints: BoxConstraints(
        maxHeight:  300,
      ),
      decoration: BoxDecoration(
        color: Colors.amber,
      ),
    );
  }
}