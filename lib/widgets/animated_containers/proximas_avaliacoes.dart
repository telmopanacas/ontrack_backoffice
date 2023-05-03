import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/services/api_requests.dart';
import 'package:ontrack_backoffice/static/colors.dart';

class ProximasAvaliacoesAC extends StatefulWidget {
  @override
  _ProximasAvaliacoesACState createState() => _ProximasAvaliacoesACState();
}

class _ProximasAvaliacoesACState extends State<ProximasAvaliacoesAC> {
  bool _isExpanded = false;
  double _expanded_width = 350;
  double _expanded_height = 300;

  double _collapsed_width = 50;
  double _collapsed_height = 250;

  /*
   *  É feito um Inkwell para termos a função onTap(), que vai alterar o estado
   * da variável _isExpanded, que vai fazer com que o AnimatedContainer mude
   * de tamanho.
   * Depois temos o AnimatedContainer que tem uma Row com dois Containers.
   * O primeiro Container é o que vai estar inicialmente visível e vai abrir o
   * resto do AnimatedContainer.
   * O segundo Container é o que vai estar inicialmente invisível e vai mostrar
   * as avaliações.
   */
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        height: _isExpanded ? _expanded_height : _collapsed_height,
        width: _isExpanded ? _expanded_width : _collapsed_width,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              width: 50,
              child: RotatedBox(
                quarterTurns: 3,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Próximas Avaliações',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Icon(
                        _isExpanded ?
                        Icons.keyboard_arrow_down_outlined:
                        Icons.keyboard_arrow_up_outlined,
                        color: Colors.white,)
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: _isExpanded ? _expanded_height : 0,
                width: _isExpanded ? _expanded_width : 0,
                color: Colors.grey[50]!.withOpacity(0.8),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        FutureBuilder(
                          future: getEventosProfID(context),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  children: snapshot.data as List<Widget>,
                                ),
                              );
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                           }
                        )
                      ]
                    ),
                  )
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
