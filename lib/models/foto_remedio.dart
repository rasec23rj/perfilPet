class FotoRemedio {
  String nome;
  String foto;
  int id;
  int remedios;

  FotoRemedio({
    this.nome,
    this.id,
    this.remedios,
    this.foto,
  });

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
    foto = map["foto"];
  }
}
