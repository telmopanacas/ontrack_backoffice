import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ontrack_backoffice/helpers/persistencia_user.dart';
import 'package:ontrack_backoffice/models/Avaliacao.dart';
import 'package:ontrack_backoffice/models/Notificacao.dart';

import '../widgets/api_data_widgets/api_data_helper.dart';

const _servidorOnTrackAPIEndpoint = 'http://localhost:8094/api/v1';

Future<List<Map<String, dynamic>>> getJsonListEventosProfID(BuildContext context) async {
  // Id do professor
  var idProf = await getUserID();

  /*
  1 - Obter os Ids das unidades curriculares do professor
  2 - Ir a cada unidade curricular e obter as avaliações e meter numa lista
  */

  var unidadesCurricularesIds = [];
  var respostaUnidadesCurriculares = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/professor/$idProf/unidades-curriculares/list'));

  if (respostaUnidadesCurriculares.statusCode == 200) {
    var resultados = jsonDecode(respostaUnidadesCurriculares.body) as List;
    var avaliacoes = [];

    for (var uc in resultados) {
      var idAvaliacao = uc['id'];
      var respostaAvaliacoes = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/unidade_curricular/$idAvaliacao/avaliacoes/list'));
      if (respostaAvaliacoes.statusCode == 200) {
        var resultadosAvaliacoes = jsonDecode(respostaAvaliacoes.body) as List;
        avaliacoes.addAll(resultadosAvaliacoes);
      } else {
        print('Erro ao obter as avaliações do professor na home page: ${respostaAvaliacoes.statusCode}.');
      }
    }
    return avaliacoes.cast<Map<String, dynamic>>();
  } else {
    print('Erro ao obter as unidades curriculares do professor na home page: ${respostaUnidadesCurriculares.statusCode}.');
    return [];
  }
}

Future<List<Widget>> getWidgetNotificacoes(String order) async {
  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/notificacao'));
  if(response.statusCode == 200) {
    var resultados = jsonDecode(response.body) as List;
    var notificacoes = resultados.map((notificacao) => Notificacao(notificacao['data'], notificacao['mensagem'])).toList();
    if(order == 'New-Old'){
      notificacoes.sort((a, b) => DateFormat('dd/MM/yyyy').parse(b.data).compareTo(DateFormat('dd/MM/yyyy').parse(a.data)));
    }else {
      notificacoes.sort((a, b) => DateFormat('dd/MM/yyyy').parse(a.data).compareTo(DateFormat('dd/MM/yyyy').parse(b.data)));
    }


    var jsonResponse= notificacoes.map((notificacao) => getNotificacaoWidget(notificacao)).toList();
    return jsonResponse;
  }else {
    print('Request failed with status: ${response.statusCode}.');
    return [];
  }
}

Future<bool> updateAvaliacao(Map<String, dynamic> avaliacao) async {

  var params = "?nome=${avaliacao['nome']}&tipoDeAvaliacao=${avaliacao['tipoDeAvaliacao']}&metodoDeEntrega=${avaliacao['metodoDeEntrega']}&data=${avaliacao['data']}&hora=${avaliacao['hora']}&descricao=${avaliacao['descricao']}&unidadeCurricularId=${avaliacao['unidadeCurricular']['id']}";
  var response = await http.put(Uri.parse('${_servidorOnTrackAPIEndpoint}/avaliacao/${avaliacao['id']}${params}'));
  if (response.statusCode == 200) {
    return true;
  } else {
    print('Request update failed with status: ${response.statusCode}.');
    return false;
  }
}

Future<bool> deleteAvaliacao(int id) async {
  // Id do professor
  var idProf = 1;

  var response = await http.delete(Uri.parse('${_servidorOnTrackAPIEndpoint}/avaliacao/delete/$id'));
  if (response.statusCode == 200) {
    return true;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return false;
  }
}

Future<bool> createAvaliacao(Map<String, dynamic> avaliacao) async {

  var response = await http.post(Uri.parse('${_servidorOnTrackAPIEndpoint}/avaliacao/new'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(avaliacao));
  if (response.statusCode == 200) {
    print('Avaliação criada com sucesso.');
    return true;
  } else {
    print('Não foi possível criar avaliação ${response.statusCode}.');
    return false;
  }
}

Future<Map<String, dynamic>> getJsonAvaliacao(String id) async {
  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/avaliacao/$id'));
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  } else {
    print('Request getAvaliacao failed with status: ${response.statusCode}.');
    return {};
  }
}

// Função usada na página detalhes da avaliação
Future<Map<String, dynamic>> getJsonUC(String unidadeCurricularId) async {

  var url = "${_servidorOnTrackAPIEndpoint}/unidade_curricular/${unidadeCurricularId}";

  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  } else {
    print('Request getUC failed with status: ${response.statusCode}.');
    return {};
  }
}


Future<List<Widget>> getWidgetsUCsProf(BuildContext context) async {
  // Id do professor
  var idProf = await getUserID();

  var url = "${_servidorOnTrackAPIEndpoint}/professor/${idProf}/unidades-curriculares/list";

  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var resultados = jsonDecode(response.body) as List;
    var jsonResponse = resultados.map((uc) => getUCWidgetFromJSON(context, uc)).toList();
    return jsonResponse;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return [];
  }
}

Future<List<Widget>> getWidgetsAvaliacoes(BuildContext context, String estado) async {
  /*
  1 - Obter as avaliações do professor
  2 - Ver se a data da avaliação é depois da data atual
  3 - Se sim, adicionar à lista de avaliações e chamar a função getAvaliacoesWidgetFromJSON
   */
  var avaliacoes = await getJsonListEventosProfID(context);
  var output = [];
  if(estado == 'A decorrer') {
    for(var avaliacao in avaliacoes) {
      String dataAvaliacaoString = avaliacao['data'];
      DateFormat inputFormat = DateFormat("dd/MM/yyyy");
      DateTime dataAvaliacao = inputFormat.parse(dataAvaliacaoString);
      if(dataAvaliacao.isAfter(DateTime.now())) {
        output.add(getAvaliacoesWidgetFromJSON(context, avaliacao));
      }
    }
  }else {
    for(var avaliacao in avaliacoes) {
      String dataAvaliacaoString = avaliacao['data'];
      DateFormat inputFormat = DateFormat("dd/MM/yyyy");
      DateTime dataAvaliacao = inputFormat.parse(dataAvaliacaoString);
      if(dataAvaliacao.isBefore(DateTime.now())) {
        output.add(getAvaliacoesWidgetFromJSON(context, avaliacao));
      }
    }
  }

  return output.cast<Widget>();
}

Future<List<Widget>> getWidgetsAvaliacoesByUC(BuildContext context, int ucId) async {

  /*
  1 - Obter a unidade curricular com o id = ucId
  2 - Obter as avaliações dessa unidade curricular
  3 - Ver quais as avaliações que estão a decorrer (o dia da avaliação ainda não passou)
  4 - Criar os widgets das avaliações e meter numa lista
   */
  var respostaUnidadeCurricular = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/unidade_curricular/$ucId'));
  var output = [];
  if(respostaUnidadeCurricular.statusCode == 200) {
    var respostaAvaliacoes = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/unidade_curricular/${ucId}/avaliacoes/list'));
    if(respostaAvaliacoes.statusCode == 200) {
      var avaliacoes = jsonDecode(respostaAvaliacoes.body) as List;
      for(var avaliacao in avaliacoes) {
        String dataAvaliacaoString = avaliacao['data'];
        DateFormat inputFormat = DateFormat("dd/MM/yyyy");
        DateTime dataAvaliacao = inputFormat.parse(dataAvaliacaoString);
        if(dataAvaliacao.isAfter(DateTime.now())) {
          output.add(getAvaliacoesWidgetFromJSON(context, avaliacao));
        }
      }
    }else {
      print('Erro ao obter as avaliações da unidade curricular: ${respostaAvaliacoes.statusCode}.');
      return [];
    }
    return output.cast<Widget>();
  }else {
    print('Erro ao a unidade curricular: ${respostaUnidadeCurricular.statusCode}.');
    return [];
  }

}

Future<List<Widget>> getWidgetsUCProfByAnoLetivo(BuildContext context, String anoLetivo) async {
  // Id do professor
  var idProf = await getUserID();

  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/professor/${idProf}/unidades-curriculares/list'));
  if (response.statusCode == 200) {
    List<Widget> output = [];
    var resultados = jsonDecode(response.body) as List;
    resultados.map((uc) {
      if(uc['anoLetivo']['ano'] == anoLetivo){
        output.add(getUCWidgetFromJSON(context, uc));
      }
    }).toList();
    return output;
  } else {
    print('Erro ao carregar as unidades curriculares');
    return [];
  }
}

Future<List<Widget>> getWidgetsAvaliacoesProfID(BuildContext context) async {
  // Id do professor
  var idProf = await getUserID();

  /*
  1 - Obter os Ids das unidades curriculares do professor
  2 - Ir a cada unidade curricular e obter as avaliações e meter numa lista
  3 - Chamar a função getHomeAvaliacoesWidgetFromJSON para cada avaliação
   */
  var unidadesCurricularesIds = [];
  var respostaUnidadesCurriculares = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/professor/$idProf/unidades-curriculares/list'));

  if(respostaUnidadesCurriculares.statusCode == 200) {
    var resultados = jsonDecode(respostaUnidadesCurriculares.body) as List;
    var avaliacoes = [];

    for(var uc in resultados) {
      var ucId = uc['id'];
      var respostaAvaliacoes = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/unidade_curricular/${ucId}/avaliacoes/list'));
      if(respostaAvaliacoes.statusCode == 200) {
        var resultados = jsonDecode(respostaAvaliacoes.body) as List;
        for(var avaliacaoJson in resultados) {
          String dataAvaliacaoString = avaliacaoJson['data'];
          DateFormat inputFormat = DateFormat("dd/MM/yyyy");
          DateTime dataAvaliacao = inputFormat.parse(dataAvaliacaoString);
          if(dataAvaliacao.isAfter(DateTime.now()))
          avaliacoes.add(getHomeAvaliacoesWidgetFromJSON(context, avaliacaoJson, Colors.white));
        }
      }else {
        print('Erro ao obter as avaliações do professor na home page: ${respostaAvaliacoes.statusCode}.');
      }
    }
    return avaliacoes.cast<Widget>();
  }else {
    print('Erro ao obter as unidades curriculares do professor na home page: ${respostaUnidadesCurriculares.statusCode}.');
    return [];
  }
}

Future<List<Widget>> getWidgetsEventosProfessorDiaX(BuildContext context, DateTime selectedDay) async{
  // Id do professor

  var avaliacoes = await getJsonListEventosProfID(context);
  var output = [];
  for (var avaliacao in avaliacoes) {
    if(avaliacao['data'] == DateFormat('dd/MM/yyyy').format(DateTime(selectedDay.year, selectedDay.month, selectedDay.day))){
      output.add(getHomeAvaliacoesWidgetFromJSON(context, avaliacao, Colors.grey[300]));
    }
  }
  return output.cast<Widget>();
}



/*
Função utilizada na página de criação de avaliações
 */
Future<List<String>> getNomesUnidadeCurriculares() async {
  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/unidade_curricular/list'));
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body) as List;
    List<String> output = [];
    jsonResponse.map((uc) {
      output.add(uc['nome']);
    }).toList();
    return output;
  } else {
    print('Erro na função getUCeIdMap no ficheiro api_requests.dart');
    return [];
  }
}

Future<Map<String, String>> getNomesEIdUCs() async {
  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/unidade_curricular/list'));
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body) as List;
    Map<String, String> output = {};
    jsonResponse.map((uc) {
      output[uc['nome']] = uc['id'].toString();
    }).toList();
    return output;
  } else {
    print('Erro na função getUCeIdMap no ficheiro api_requests.dart');
    return {};
  }
}

/*
Função que vai buscar todos as Unidades Curriculares do professor, vê se existe alguma com o mesmo nome passado
e retorna o id dessa UC
 */
Future<int> getUCId(String nomeUC) async {
  // Id do professor
  var idProf = await getUserID();

  var response = await http.get(Uri.parse(
      '${_servidorOnTrackAPIEndpoint}/professor/${idProf}/unidades-curriculares/list'));
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body) as List;
    int output = 0;
    jsonResponse.map((uc) {
      if (uc['nome'] == nomeUC) {
        output = uc['id'];
      }
    }).toList();
    return output;
  } else {
    print('Erro na função getUCeIdMap no ficheiro api_requests.dart');
    return -1;
  }
}

/*
Função que vai buscar o nome da Unidade Curricular do professor com id X
 */
Future<String> getUCNome(String idUC) async {
  var response = await http.get(Uri.parse(
      '${_servidorOnTrackAPIEndpoint}/unidade_curricular/${idUC}'));
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse['nome'];
  } else {
    print('Erro na função getUCNome no ficheiro api_requests.dart');
    return '';
  }
}

/*
Função que vai buscar todos os alunos de uma Unidade Curricular
 */
Future<List<String>> getListaAlunosUC(int idUC) async {
  var response = await http.get(Uri.parse(
      '${_servidorOnTrackAPIEndpoint}/unidade_curricular/${idUC}'));
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var alunos = jsonResponse['alunos'] as List;
    List<String> output = [];
    alunos.map((aluno) {
      output.add(aluno['nome']+ ' - ' + aluno['email'].split('@')[0]);
    }).toList();
    return output;
  } else {
    print('Erro na função getListaAlunosUC no ficheiro api_requests.dart');
    return [];
  }
}

/*
Função que vai obter o número de unidades curriculares de um professor
 */
Future<int> getProfessorUcCount() async {
  var idProf = await getUserID();
  var response = await http.get(Uri.parse(
      '${_servidorOnTrackAPIEndpoint}/professor/${idProf}/unidades-curriculares/list'));
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body) as List;
    return jsonResponse.length;
  } else {
    print('Erro na função getProfessorUcCount no ficheiro api_requests.dart');
    return -1;
  }
}

Future <Map<String, int>> getCursos() async {
  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/curso/list'));
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body) as List;
    Map<String, int> output = {};
    jsonResponse.map((curso) {
      output[curso['nome']] = curso['id'];
    }).toList();
    return output;
  } else {
    print('Erro na função getCursos no ficheiro api_requests.dart');
    return {};
  }
}
