class Sintomas {
  String _protocolo;
  String _idUsuario;
  bool _febre;
  bool _diarreia;
  bool _coriza;
  bool _tosse;
  bool _espirro;
  String _descricao;
  String _urlImagem;
  double _temperatura;



  Sintomas();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idUsuario": this.idUsuario,
      "febre": this.febre,
      "diarreia": this.diarreia,
      "coriza": this.coriza,
      "tosse": this.tosse,
      "espirro": this.espirro,
      "descricao": this.descricao,
      "urlImagem": this.urlImagem,
      "temperatura": this.temperatura
    };

    return map;
  }

  double get temperatura => _temperatura;

  set temperatura(double value) {
    _temperatura = value;
  }
  String get urlImagem => _urlImagem;

  set urlImagem(String value) {
    _urlImagem = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  bool get espirro => _espirro;

  set espirro(bool value) {
    _espirro = value;
  }

  bool get tosse => _tosse;

  set tosse(bool value) {
    _tosse = value;
  }

  bool get coriza => _coriza;

  set coriza(bool value) {
    _coriza = value;
  }

  bool get diarreia => _diarreia;

  set diarreia(bool value) {
    _diarreia = value;
  }

  bool get febre => _febre;

  set febre(bool value) {
    _febre = value;
  }

  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  String get protocolo => _protocolo;

  set protocolo(String value) {
    _protocolo = value;
  }


}