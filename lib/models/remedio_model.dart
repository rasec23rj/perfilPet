import 'package:lifepet_app/models/pet_model.dart';

class Remedio {
  String nome;
  String inicioData;
  String fimData;
  String hora;
  String descricao;
  int id;
  int pet;

  Remedio(
      {this.nome,
        this.inicioData,
        this.fimData,
        this.hora,
        this.descricao,
        this.id,
        this.pet});



  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "pet": pet,
      "inicioData": inicioData.toString(),
      "fimData": fimData.toString(),
      "descricao": descricao.toString(),
      "hora": hora.toString()
    };
  }

  Remedio.fromMap(Map map) {
    id = map["id"];
    nome = map["nome"];
    pet = map["pet"];
    inicioData = map["inicioData"];
    fimData = map["fimData"];
    descricao = map["descricao"];
    hora = map["hora"];
  }


}
