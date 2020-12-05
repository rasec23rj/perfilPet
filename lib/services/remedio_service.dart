import 'dart:math';

import 'package:lifepet_app/models/foto_remedio.dart';
import 'package:lifepet_app/models/remedio_model.dart';
import 'package:lifepet_app/services/pet_service.dart';
import 'package:lifepet_app/utils/db_utils.dart';

class RemedioService {
  List<Remedio> _remedioList = [];
  final PetService petService = PetService();
  List<String> colunas = [
    "id",
    "nome",
    "inicioData",
    "fimData",
    "hora",
    "descricao",
    "pet"
  ];

  Future<List> getRemedioPets(int id) async {
    String whereString = "pet = ?";
    List<dynamic> whereArgumento = [id];
    final dataList = await DbUtil.getDataWhere(
        "remedios", colunas, whereString, whereArgumento);

    return dataList.map((remedios) => Remedio.fromMap(remedios)).toList();
  }

  void addRemedio(Remedio remedio) async {
    DbUtil.insertData("remedios", remedio.toMap());
  }

  Future<Remedio> getRemedio(int id) async {
    String whereString = "id = ?";
    List<dynamic> whereArgumento = [id];
    final dataList = await DbUtil.getDataWhere(
        "remedios", colunas, whereString, whereArgumento);

    return Remedio.fromMap(dataList.first);
  }

  Future<Remedio> getDetalheRemedio(int id) async {
    String whereString = "id = ?";
    List<dynamic> whereArgumento = [id];
    final dataList = await DbUtil.getDataWhere(
        "remedios", colunas, whereString, whereArgumento);

    return Remedio.fromMap(dataList.first);
  }

  List<String> colunasFotos = ["id", "nome", "remedios"];

  Future<List> getFotoRemedio(int id) async {
    String whereString = "remedios = ?";
    List<dynamic> whereArgumento = [id];
    final dataList = await DbUtil.getDataWhere(
        "fotosRemedios", colunasFotos, whereString, whereArgumento);
    return dataList
        .map((fotosRemedios) => FotoRemedio.fromMap(fotosRemedios))
        .toList();
  }
}
