import 'dart:math';

import 'package:lifepet_app/models/remedio_model.dart';
import 'package:lifepet_app/services/pet_service.dart';
import 'package:lifepet_app/utils/db_utils.dart';

class RemedioService {
  List<Remedio> _remedioList = [];
  final PetService petService = PetService();
  List<String> colunas = ["id", "nome", "data","hora", "pet"];
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
    final dataList = await DbUtil.getDataWhere("remedios", colunas, whereString, whereArgumento);
    return Remedio.fromMap(dataList.first);
  }
}
