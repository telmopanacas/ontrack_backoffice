import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/services/api_requests.dart';
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
  final List<String> _anos = ['2020/2021', '2021/2022', '2022/2023', '2023/2024', '2024/2025', '2025/2026'];
  String _selectedAno = '2020/2021';


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
                SizedBox(height: 20),
                Text(
                  'As suas unidades curriculares',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ano letivo: ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      buildAnoLetivoButtao(),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                buildUCsContainer(context)

              ],
            ),
          ),
        )
      ),
    );
  }

  DropdownButton2<String> buildAnoLetivoButtao() {
    return DropdownButton2(
      isExpanded: true,
      items: _anos.map((ano) => DropdownMenuItem<String>(
        value: ano,
        child: Text('$ano'),
      )).toList(),
      value: _selectedAno,
      style: const TextStyle(
        color: Color(0xFFCA0944),
        fontSize: 15,

      ),
      onChanged: (value) {
        setState(() {
          _selectedAno = value as String;
          print(value);
        });
      },

      //Dimensões do dropdown
      dropdownStyleData: const DropdownStyleData(
        maxHeight: 200,
        width: 115,
      ),

      //Dimensões do botão
      buttonStyleData: const ButtonStyleData(
        height: 40,
        width: 100,

      ),

      //Dimensões de cada item do dropdown
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
      ),
    );
  }

  Container buildUCsContainer(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.4,
      ),
      child: FutureBuilder(
        future: getUCProfByAnoLetivo(context, _selectedAno),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data.toString() == '[]') {
              return Text(
                'Não existem unidades curriculares para este ano letivo.',
                style: TextStyle(
                    color: Colors.black, fontSize: 17),
              );
            }
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
