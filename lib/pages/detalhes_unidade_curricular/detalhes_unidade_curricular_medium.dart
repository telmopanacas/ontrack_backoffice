import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ontrack_backoffice/models/UnidadeCurricular.dart';
import 'package:ontrack_backoffice/services/api_requests.dart';
import 'package:ontrack_backoffice/static/colors.dart';
import 'package:ontrack_backoffice/widgets/app_bar/app_bar.dart';
import 'package:ontrack_backoffice/widgets/app_bar/drawer.dart';

class DetalhesUnidadeCurricularMedium extends StatefulWidget {
  final String? ucId;
  const DetalhesUnidadeCurricularMedium({Key? key, this.ucId}) : super(key: key);

  @override
  State<DetalhesUnidadeCurricularMedium> createState() => _DetalhesUnidadeCurricularMediumState();
}

class _DetalhesUnidadeCurricularMediumState extends State<DetalhesUnidadeCurricularMedium> {
  List<String> alunos = [
    "João Pedro - a22001972",
    "Maria Silva - a22002345",
    "Pedro Costa - a22005789",
    "Ana Luiza - a22001234",
    "Fernando Souza - a22009876",
    "Mariana Santos - a22005432",
    "Lucas Oliveira - a22006543",
    "Isabela Almeida - a22003456",
    "Rafaela Carvalho - a22008765",
    "Gabriel Vieira - a22007890",
    "Luiz Felipe - a22007654",
    "Amanda Ribeiro - a22004321",
    "Juliana Costa - a22005678",
    "Thiago Oliveira - a22004567",
    "Carla Santos - a22009987",
  ];


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUC(widget.ucId!),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          UnidadeCurricular uc = UnidadeCurricular.fromJson(snapshot.data as Map<String, dynamic>);

          return Scaffold(
            appBar: buildAppBar(context, 'Unidades Curriculares'),
            //drawer: buildDrawer(context),
            body: Container(
              width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              color: background,
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 50, 50, 20),
                    child: Column(
                      children: [
                        Text(
                          'Detalhes Unidade Curricular',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 50),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          constraints: BoxConstraints(
                            minHeight: 600,
                          ),
                          child: Row(
                            children: [
                              buildDetalhesUC(uc),
                              SizedBox(width: 40),
                              buildAvaliacoes(uc),
                            ],
                          )
                        )
                      ],
                    ),
                  ),
                ),
              )
            ),
          );
        } else if(snapshot.hasError) {
          return Text('${snapshot.error}');
        }else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );


  }

  Widget buildAvaliacoes(UnidadeCurricular uc) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.5),
      ),
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 30, 50, 20),
        child: Column(
          children: [
            Text(
              'Avaliações',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Divider(thickness: 2, color: Colors.black,),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(150, 40),
                  ),
                  onPressed:() => GoRouter.of(context).push('/criar_avaliacao'),
                  child: Text('Criar Avaliação'),
                ),
              ],
            ),
            SizedBox(height: 30),
            buildAvaliacoesContainer(context, uc.nome),
          ],
        ),
      ),
    );
  }

  Container buildAvaliacoesContainer(BuildContext context, String ucID) {
    return Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery
              .of(context)
              .size
              .height * 0.4,
        ),
        child: FutureBuilder(
            future: getAvaliacoesByUC(context, ucID),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.toString() == '[]') {
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

  Expanded buildDetalhesUC(UnidadeCurricular uc) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.5),
        ),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        height: MediaQuery.of(context).size.height * 0.7,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 30, 50, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${uc.nome}',
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 50),
              RichText(
                text: TextSpan(
                  text: 'Ano Letivo: ',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                  children: <TextSpan>[
                    TextSpan(text: uc.anoLetivo.ano, style: TextStyle(fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Curso: ',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                  children: <TextSpan>[
                    TextSpan(text: uc.curso.codigo, style: TextStyle(fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Semestre: ',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
                  children: <TextSpan>[
                    TextSpan(text: uc.semestre.toString(), style: TextStyle(fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Flexible(
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          'Alunos Inscritos',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(thickness: 2, color: Colors.black,),
                        SizedBox(height: 10),
                        Flexible(
                          child: Container(
                            width: 240,

                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: alunos.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(alunos[index], style: TextStyle(fontSize: 17),),
                                );
                              },
                            ),

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
      )
    );
  }
}
