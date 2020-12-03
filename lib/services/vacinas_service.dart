import 'package:lifepet_app/models/vacinas.dart';
import 'package:lifepet_app/utils/db_utils.dart';

class VacinasService {
  List<Vacinas> _vacinasList = [];
  List<String> colunas = ["id", "nome", "inicioData", "fimData", "hora", "pet"];

  Future<List> getVacinasPets(int id) async {
    String whereString = 'pet = ?';
    List<dynamic> whereArgumento = [id];
    final dataList = await DbUtil.getDataWhere(
        'vacinas', colunas, whereString, whereArgumento);
    print("vacinasService: ${dataList.length}");
    return dataList.map((vacinas) => Vacinas.fromMap(vacinas)).toList();
  }

  void addVcinas(Vacinas vacinas) async {
    DbUtil.insertData('vacinas', vacinas.toMap());
  }

  Future<Vacinas> getVacinas(int id) async {
    String whereString = 'id = ?';
    List<dynamic> whereArgumento = [id];
    final dataList = await DbUtil.getDataWhere(
        'vacinas', colunas, whereString, whereArgumento);
    return Vacinas.fromMap(dataList.first);
  }
}
