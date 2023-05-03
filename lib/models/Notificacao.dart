class Notificacao {
  final String _data;
  final String _mensagem;

  Notificacao(this._data, this._mensagem);

  String get data => _data;

  String get mensagem => _mensagem;

  Notificacao.fromJson(Map<String, dynamic> json)
      : _data = json['data'],
        _mensagem = json['mensagem'];

  @override
  String toString() {
    return 'Notificacao{_data: $_data, _mensagem: $_mensagem}';
  }

}