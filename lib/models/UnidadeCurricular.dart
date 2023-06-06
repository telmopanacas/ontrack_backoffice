import 'package:ontrack_backoffice/models/Aluno.dart';
import 'package:ontrack_backoffice/models/AnoLetivo.dart';
import 'package:ontrack_backoffice/models/Curso.dart';

class UnidadeCurricular {
  final String id;
  final String nome;
  final String codigo;
  final String descricao;
  final int ano;
  final int semestre;
  final Curso curso;
  final AnoLetivo anoLetivo;
  final List<Aluno> alunos;

  UnidadeCurricular(this.id, this.nome, this.codigo, this.descricao, this.ano, this.semestre, this.curso, this.anoLetivo, this.alunos);

  @override
  String toString() {
    return 'UnidadeCurricular{id: $id, nome: $nome, codigo: $codigo, descricao: $descricao, ano: $ano, semestre: $semestre, curso: $curso, anoLetivo: $anoLetivo}';
  }

  factory UnidadeCurricular.fromJson(Map<String, dynamic> json) {
    return UnidadeCurricular(
      json['id'] as String,
      json['nome'] as String,
      json['codigo'] as String,
      json['descricao'] as String,
      json['ano'] as int,
      json['semestre'] as int,
      Curso.fromJson(json['curso']),
      AnoLetivo.fromJson(json['anoLetivo']),
      (json['alunos'] as List).map((e) => Aluno.fromJson(e)).toList(),
    );
  }
}
