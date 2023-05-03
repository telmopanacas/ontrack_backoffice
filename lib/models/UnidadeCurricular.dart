class UnidadeCurricular {
  final int _createdAt;
  final String _name;
  final String _curso;
  final String _ano;
  final int _semestre;
  final String _descricao;
  final String _id;
  final String _professorId;

  UnidadeCurricular(this._createdAt, this._name, this._curso, this._ano,
      this._semestre, this._descricao, this._id, this._professorId);

  factory UnidadeCurricular.fromJson(Map<String, dynamic> json) {
    return UnidadeCurricular(
        json['createdAt'],
        json['name'],
        json['curso'],
        json['ano'],
        json['semestre'],
        json['descricao'],
        json['id'],
        json['professorId']
    );
  }

  String get professorId => _professorId;

  String get id => _id;

  String get descricao => _descricao;

  int get semestre => _semestre;

  String get ano => _ano;

  String get curso => _curso;

  String get name => _name;

  int get createdAt => _createdAt;
}