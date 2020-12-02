import 'dart:wasm';

import 'package:lifepet_app/models/foto_remedio.dart';
import 'package:lifepet_app/utils/db_utils.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class FotoRemedioService {
  List<String> colunas = ["id", "nome", "remedios"];

  Future<List> getFotoRemedio(int id) async {
    String whereString = "remedios = ?";
    List<dynamic> whereArgumento = [id];
    final dataList = await DbUtil.getDataWhere(
        "fotosRemedios", colunas, whereString, whereArgumento);

    return dataList
        .map((fotosRemedios) => FotoRemedio.fromMap(fotosRemedios))
        .toList();
  }

  void addFotoRemedio(FotoRemedio fotosRemedios) {
    DbUtil.insertData("fotosRemedios", fotosRemedios.toMap());
  }

  Future<String> deleteFotoRemedio(int id) async {
    var db = await sql.openDatabase('pets.db');

    db
        .rawQuery('DELETE FROM fotosRemedios where fotosRemedios.id = ${id}')
        .then((value) {
      return value.length;
    });
  }

  Future<FotoRemedio> updateRemedio(int id, FotoRemedio fotoRemedio) async {
    String whereString = "id = ?";
    List<dynamic> whereArgumento = [id];

    DbUtil.updteData(
        "fotosRemedios", fotoRemedio.toMap(), whereString, whereArgumento);
  }

  Future<FotoRemedio> getFotoRemedioFist(int id) async {
    String whereString = "remedios = ?";
    List<dynamic> whereArgumento = [id];
    final dataList = await DbUtil.getDataWhere(
        "fotosRemedios", colunas, whereString, whereArgumento);
    return FotoRemedio.fromMap(dataList.first);
  }

  Future<FotoRemedio> getDetalheRemedio(int id) async {
    String whereString = "id = ?";
    List<dynamic> whereArgumento = [id];
    final dataList = await DbUtil.getDataWhere(
        "fotosRemedios", colunas, whereString, whereArgumento);

    return FotoRemedio.fromMap(dataList.first);
  }

  Future<List> getDatabase(int id) async {
    var db = await sql.openDatabase('pets.db');
    List<Map> list = await db.rawQuery(
        'SELECT fotosRemedios.nome as foto, remedios.nome, remedios.id, remedios.descricao, remedios.hora, remedios.inicioData, remedios.fimData ' +
            'FROM fotosRemedios inner join remedios  on fotosRemedios.remedios = remedios.id where fotosRemedios.remedios = ${id}');
    print("getDatabase: ${list}");
    return list
        .map((fotosRemedios) => FotoRemedio.fromMap(fotosRemedios))
        .toList();
  }
}
