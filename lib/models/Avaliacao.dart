class Avaliacao {
  final int _createdAt;
  final String _name;
  final String _data_realizacao;
  final String _estado;
  final String _metodo_entrega;
  final String _tipo;
  final String _ucId;
  final String _descricao;
  final String _hora_realizacao;
  final String _id;
  final String _professorId;

  Avaliacao(
      this._createdAt,
      this._name,
      this._data_realizacao,
      this._estado,
      this._metodo_entrega,
      this._tipo,
      this._ucId,
      this._descricao,
      this._hora_realizacao,
      this._id,
      this._professorId
      );

  factory Avaliacao.fromJson(Map<String, dynamic> json) {
    return Avaliacao(
      json['createdAt'],
      json['name'],
      json['data_realizacao'],
      json['estado'],
      json['metodo_entrega'],
      json['tipo'],
      json['ucId'],
      json['descricao'],
      json['hora_realizacao'],
      json['id'],
      json['professorId']
    );
  }

  String get professorId => _professorId;

  String get id => _id;

  String get hora_realizacao => _hora_realizacao;

  String get descricao => _descricao;

  String get ucId => _ucId;

  String get tipo => _tipo;

  String get metodo_entrega => _metodo_entrega;

  String get estado => _estado;

  String get data_realizacao => _data_realizacao;

  String get name => _name;

  int get createdAt => _createdAt;
}