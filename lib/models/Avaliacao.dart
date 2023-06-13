import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Avaliacao {
  final String _id;
  final String _name;
  final String _tipoDeAvaliacao;
  final String _metodoDeEntrega;
  final String _data;
  final String _hora;
  final String _descricao;
  final String _ucId;
  final String _estado;

  Avaliacao(
      this._id,
      this._name,
      this._tipoDeAvaliacao,
      this._metodoDeEntrega,
      this._data,
      this._hora,
      this._descricao,
      this._ucId,
      this._estado,
      );

  factory Avaliacao.fromJson(Map<String, dynamic> json) {
    String dataAvaliacaoString = json['data'];
    DateFormat inputFormat = DateFormat("dd/MM/yyyy");
    DateTime dataAvaliacao = inputFormat.parse(dataAvaliacaoString);

    return Avaliacao(
      json['id'].toString(),
      json['nome'],
      json['tipoDeAvaliacao'],
      json['metodoDeEntrega'],
      json['data'],
      json['hora'],
      json['descricao'],
      json['unidadeCurricular']['id'].toString(),
      dataAvaliacao.isAfter(DateTime.now()) ? 'A decorrer' : 'Terminada',
    );
  }

  String get estado => _estado;

  String get ucId => _ucId;

  String get descricao => _descricao;

  String get hora => _hora;

  String get data => _data;

  String get metodoDeEntrega => _metodoDeEntrega;

  String get tipoDeAvaliacao => _tipoDeAvaliacao;

  String get name => _name;

  String get id => _id;
}