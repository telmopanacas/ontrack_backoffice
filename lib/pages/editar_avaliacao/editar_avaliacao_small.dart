import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar.dart';

class EditarAvaliacaoSmall extends StatefulWidget {
  final String? avaliacaoId;
  const EditarAvaliacaoSmall({Key? key, this.avaliacaoId}) : super(key: key);

  @override
  State<EditarAvaliacaoSmall> createState() => _EditarAvaliacaoSmallState();
}

class _EditarAvaliacaoSmallState extends State<EditarAvaliacaoSmall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Avaliações'),
      body: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        color: Colors.white,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
                  child: Column(
                    children: [
                      Text(
                        'Editar Avaliação Small',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
