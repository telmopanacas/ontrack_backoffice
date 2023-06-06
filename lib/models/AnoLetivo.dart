class AnoLetivo {
  final String id;
  final String ano;

  AnoLetivo(this.id, this.ano);

  @override
  String toString() {
    return 'AnoLetivo{id: $id, ano: $ano}';
  }

  factory AnoLetivo.fromJson(Map<String, dynamic> json) {
    return AnoLetivo(
      json['id'] as String,
      json['ano'] as String,
    );
  }
}