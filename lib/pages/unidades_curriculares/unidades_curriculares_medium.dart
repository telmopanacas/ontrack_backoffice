import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/static/colors.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar.dart';
import 'package:ontrack_backoffice/widgets/app_bar/drawer.dart';

class UnidadesCurricularesMedium extends StatefulWidget {
  const UnidadesCurricularesMedium({Key? key}) : super(key: key);

  @override
  State<UnidadesCurricularesMedium> createState() => _UnidadesCurricularesMediumState();
}

class _UnidadesCurricularesMediumState extends State<UnidadesCurricularesMedium> {
  //TODO: Ir à API buscar os anos letivos
  final List<String> _anos = ['Ano letivo 2020', 'Ano letivo 2021', 'Ano letivo 2022', 'Ano letivo 2023', 'Ano letivo 2024', 'Ano letivo 2025'];
  String? _selectedAno = 'Ano letivo 2020';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(context, 'Unidades Curriculares'),
      drawer: buildDrawer(context),
      body: Container(
        color: background,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
            child: Column(
              children: [
                DropdownButton2(
                  isExpanded: true,
                  hint: Text('Ano letivo 2020'),
                  items: _anos.map((ano) => DropdownMenuItem<String>(
                    value: ano,
                    child: Text('$ano'),
                  )).toList(),
                  value: _selectedAno,
                  onChanged: (value) {
                    setState(() {
                      _selectedAno = value;
                      print(_selectedAno);
                    });
                  },
                  dropdownStyleData: const DropdownStyleData(
                    maxHeight: 200,
                    width: 140,
                  ),
                  buttonStyleData: const ButtonStyleData(
                    height: 40,
                    width: 140,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
