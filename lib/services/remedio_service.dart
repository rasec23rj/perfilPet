import 'dart:math';

import 'package:intl/intl.dart';
import 'package:lifepet_app/helpers/notifications_manager.dart';
import 'package:lifepet_app/models/foto_remedio.dart';
import 'package:lifepet_app/models/remedio_model.dart';
import 'package:lifepet_app/services/foto_remedio_service.dart';
import 'package:lifepet_app/services/pet_service.dart';
import 'package:lifepet_app/utils/db_utils.dart';

class RemedioService {
  List<Remedio> _remedioList = [];
  String updatedDt;
  String updatedDtFinal;
  String horaTimer;
  String dataRemedio;
  PetService petService = PetService();
  FotoRemedioService fotoRemedioService = FotoRemedioService();
  NotificationManager notificationManager = NotificationManager();

  List<String> colunas = [
    "id",
    "nome",
    "inicioData",
    "fimData",
    "hora",
    "descricao",
    "pet"
  ];
  void notificacao() {
    notificationManager.initialuzeNotificatios();
  }

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



  Future<List> getFotoRemedios(int id) async {
    return await fotoRemedioService.getFotoRemedio(id);
  }

  Future<void> deleteFotoRemedios(int id) async {
    return await fotoRemedioService.deleteFotoRemedio(id);
  }

  void sheduleDailyNotifications(
      String horaRemedio, String dataRemedio, String nome, String pet) {
    int hora = int.parse(horaRemedio.substring(0, 2));
    int miniute = int.parse(horaRemedio.substring(3, 5));
    String strDt = dataRemedio;
    DateTime parseDt = DateTime.parse(strDt);
    var newFormat = DateFormat("dd/MM/yyyy");
    String dateRemedioFinal = newFormat.format(parseDt);
    notificationManager.sheduleDailyNotifications(
        hora, miniute, dateRemedioFinal, nome, pet);
  }

  void showNotificationAgenda(
      String horaRemedio, String dataRemedio, String nome, String pet) {
    String strDt = dataRemedio;
    DateTime parseDt = DateTime.parse(strDt);
    var newFormat = DateFormat("dd/MM/yyyy");
    var now = new DateTime.now();

    int hora = int.parse(horaRemedio.substring(0, 2));
    int miniute = int.parse(horaRemedio.substring(3, 5));
    String horaFinal = "${hora}:${miniute}";

    String horaNow = "${now.hour}:${now.minute}";
    String dateRemedioTeste = newFormat.format(parseDt);
    String dateRemedioNow = newFormat.format(now);

    if (horaNow == horaFinal && dateRemedioTeste == dateRemedioNow) {}
    if (dataRemedio != null) {
      notificationManager.showNotificationsAgenda(
          hora, miniute, dataRemedio, nome, pet);
    }
  }

  void showNotificationAgendaTeste(
      String horaRemedio, String dataRemedio, String nome, String pet) {
    String strDt = dataRemedio;
    DateTime parseDt = DateTime.parse(strDt);
    var newFormat = DateFormat("dd/MM/yyyy");
    var now = new DateTime.now();

    int hora = int.parse(horaRemedio.substring(0, 2));
    int miniute = int.parse(horaRemedio.substring(3, 5));
    String horaFinal = "${hora}:${miniute}";

    String horaNow = "${now.hour}:${now.minute}";
    String dateRemedioTeste = newFormat.format(parseDt);
    String dateRemedioNow = newFormat.format(now);

    if (horaNow == now &&
        dateRemedioTeste == dateRemedioNow &&
        dataRemedio != null) {
      notificationManager.showNotificationsAgendaTeste(
          hora, miniute, dateRemedioTeste, nome, pet);
    }
    if (dataRemedio != null) {
      updatedDt = newFormat.format(parseDt);
    }
  }

  void agenda(String horaRemedio, String dataRemedio, String nome, String pet) {
    int hora = int.parse(horaRemedio.substring(0, 2));
    int miniute = int.parse(horaRemedio.substring(3, 5));
    String strDt = dataRemedio;
    DateTime parseDt = DateTime.parse(strDt);
    var newFormat = DateFormat("dd/MM/yyyy");
    String dateRemedioFinal = newFormat.format(parseDt);
    notificationManager.agendaNT(hora, miniute, dateRemedioFinal, nome, pet);
  }

  void showPeriodos(
      String horaRemedio, String dataRemedio, String nome, String pet) {
    int hora = int.parse(horaRemedio.substring(0, 2));
    int miniute = int.parse(horaRemedio.substring(3, 5));
    String strDt = dataRemedio;
    DateTime parseDt = DateTime.parse(strDt);
    var newFormat = DateFormat("dd/MM/yyyy");
    String dateRemedioFinal = newFormat.format(parseDt);
    notificationManager.showNotificationsAgendaPeriodo(
        hora, miniute, dateRemedioFinal, nome, pet);
  }


}
