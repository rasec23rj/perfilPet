class Vermifugos {
  String nome;
  String inicioData;
  String fimData;
  String hora;
  int id;
  int pet;

  Vermifugos(
      {this.nome, this.inicioData, this.fimData, this.hora, this.id, this.pet});

  Map<String, dynamic> toMap() {
    return {
      "nome": nome,
      "pet": pet,
      "inicioData": inicioData.toString(),
      "fimData": fimData.toString(),
      "hora": hora.toString()
    };
  }

  Vermifugos.fromMap(Map map) {
    id = map["id"];
    nome = map["nome"];
    pet = map["pet"];
    inicioData = map["inicioData"];
    fimData = map["fimData"];
    hora = map["hora"];
  }
}
