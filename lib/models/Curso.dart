class Curso {
  final int id;
  final String nome;
  final String codigo;

  Curso(this.id, this.nome, this.codigo);

  @override
  String toString() {
    return 'Curso{id: $id, nome: $nome, codigo: $codigo}';
  }

factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      json['id'] as int,
      json['nome'] as String,
      json['codigo'] as String,
    );
  }
}