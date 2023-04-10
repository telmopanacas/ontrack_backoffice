import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/services/api_requests.dart';
import 'package:ontrack_backoffice/static/colors.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar.dart';
import 'package:ontrack_backoffice/widgets/app_bar/drawer.dart';

class AvaliacoesMedium extends StatefulWidget {
  const AvaliacoesMedium({Key? key}) : super(key: key);

  @override
  State<AvaliacoesMedium> createState() => _AvaliacoesMediumState();
}

class _AvaliacoesMediumState extends State<AvaliacoesMedium> {
  final List<String> _estados = ['A decorrer', 'Terminadas'];
  String _selectedEstado = 'A decorrer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Avaliações'),
      drawer: buildDrawer(context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        color: background,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
              child: Column(
                children: [
                  Text(
                    'As suas avaliações',
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
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Estado: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        buildEstadoButao(),
                      ],
                    )
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/criar_avaliacao');
                    },
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFCA0944),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Criar Avaliação',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.add, color: Colors.white,)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  buildAvaliacoesContainer(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DropdownButton2<String> buildEstadoButao() {
    return DropdownButton2(
      isExpanded: true,
      items: _estados.map((estado) => DropdownMenuItem<String>(
        value: estado,
        child: Text(estado),
      )).toList(),
      value: _selectedEstado,
      style: const TextStyle(
        color: Color(0xFFCA0944),
        fontSize: 15,
      ),
      onChanged: (value) {
        setState(() {
          _selectedEstado = value!;
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
        width: 110,

      ),

      //Dimensões de cada item do dropdown
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
      ),
    );

  }

  Container buildAvaliacoesContainer(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.4,
      ),
      child: FutureBuilder(
        future: getAvaliacoes(context, _selectedEstado),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data.toString() == '[]') {
              return Text(
                'Não tem avaliações',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              );
            }
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                spacing: 15,
                runSpacing: 15,
                alignment: WrapAlignment.start,
                children: snapshot.data as List<Widget>
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        }
      )
    );
  }
}
