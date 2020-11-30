class FotoRemedio {
  String nome;
  int id;
  int remedios;

  FotoRemedio({this.nome, this.id, this.remedios});

  Map<String, dynamic> toMap() {
    return {
      "nome": nome,
      "remedios": remedios,
    };
  }

  FotoRemedio.fromMap(Map map) {
    id = map["id"];
    nome = map["nome"];
    remedios = map["remedios"];
  }
}
