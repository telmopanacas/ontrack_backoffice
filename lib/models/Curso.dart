class Curso {
  final String id;
  final String nome;
  final String codigo;

  Curso(this.id, this.nome, this.codigo);

  @override
  String toString() {
    return 'Curso{id: $id, nome: $nome, codigo: $codigo}';
  }

factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      json['id'] as String,
      json['nome'] as String,
      json['codigo'] as String,
    );
  }
}