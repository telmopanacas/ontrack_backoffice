import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/static/colors.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar.dart';

class EditarAvaliacaoMedium extends StatefulWidget {
  const EditarAvaliacaoMedium({Key? key}) : super(key: key);

  @override
  State<EditarAvaliacaoMedium> createState() => _EditarAvaliacaoMediumState();
}

class _EditarAvaliacaoMediumState extends State<EditarAvaliacaoMedium> {
  double _larguraTextFields = 400;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Avaliações'),
      body: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        color: background,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Editar Avaliação',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    alignment: Alignment.centerLeft,

                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
