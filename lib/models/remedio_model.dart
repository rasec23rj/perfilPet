import 'package:lifepet_app/models/pet_model.dart';

class Remedio {
  String nome;
  String data;
  String hora;
  int id;
  int pet;

  Remedio({this.nome, this.data, this.hora, this.id, this.pet});

  Map<String, dynamic> toMap() {
    return {"id": id, "nome": nome, "pet": pet, "data": data.toString(), "hora": hora.toString()};
  }

  Remedio.fromMap(Map map) {
    id = map["id"];
    nome = map["nome"];
    pet = map["pet"];
    data = map["data"];
    hora = map["hora"];
  }
}
