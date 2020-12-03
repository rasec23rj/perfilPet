import 'package:lifepet_app/models/Vermifugos.dart';
import 'package:lifepet_app/utils/db_utils.dart';

class VermifugosService {
  List<Vermifugos> _vermifugosList = [];
  List<String> colunas = ["id", "nome", "inicioData", "fimData", "hora", "pet"];
  String table = 'Vermifugos';
  Future<List> getVermifugosPets(int id) async {
    String whereString = 'pet = ?';
    List<dynamic> whereArgumento = [id];
    final dataList =
        await DbUtil.getDataWhere(table, colunas, whereString, whereArgumento);
    return dataList.map((e) => Vermifugos.fromMap(e)).toList();
  }

  void addVcinas(Vermifugos vermifugos) async {
    DbUtil.insertData(table, vermifugos.toMap());
  }

  Future<Vermifugos> getVermifugos(int id) async {
    String whereString = 'id = ?';
    List<dynamic> whereArgumento = [id];
    final dataList =
        await DbUtil.getDataWhere(table, colunas, whereString, whereArgumento);
    return Vermifugos.fromMap(dataList.first);
  }
}
