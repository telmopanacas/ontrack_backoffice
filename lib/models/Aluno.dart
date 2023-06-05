class Aluno {
  final String nome;
  final String email;
  final String numeroAluno;

  Aluno(this.nome, this.email, this.numeroAluno);

  @override
  String toString() {
    return 'Aluno{nome: $nome, email: $email, numeroAluno: $numeroAluno}';
  }

  factory Aluno.fromJson(Map<String, dynamic> json) {
    String numeroAluno = json['email'] as String;
    numeroAluno.split('@')[0];

    return Aluno(
      json['nome'] as String,
      json['email'] as String,
      numeroAluno,
    );
  }
}