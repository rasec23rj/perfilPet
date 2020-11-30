import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lifepet_app/helpers/notifications_manager.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/models/remedio_model.dart';
import 'file:///C:/Users/jt/Desktop/Projetos/perfilPet-master/lib/screens/remedio/components/form_remedio_pet_screen.dart';
import 'package:lifepet_app/services/pet_service.dart';
import 'package:lifepet_app/services/remedio_service.dart';
import 'package:lifepet_app/components/custom_navbar.dart';
import 'package:lifepet_app/components/navbar_remedio.dart';
import 'package:lifepet_app/screens/remedio/components/detalhe_remedio.dart';
import 'package:intl/intl.dart';

class RemedioScreen extends StatefulWidget {
  int id;
  int cor = 0;
  Pet pet;
  var teste = TextDecoration.none;
  var textoButton = '"Concluir"';
  var iconButton = Icons.close;
  var corButton = 0;

  RemedioScreen({this.id, this.pet});

  @override
  _RemedioScreenState createState() => _RemedioScreenState();
}

class _RemedioScreenState extends State<RemedioScreen> {
  int _counter = 0;
  NotificationManager notificationManager = NotificationManager();
  var texto = '0';
  final PetService petService = PetService();
  final RemedioService remedioService = RemedioService();
  List<Remedio> remedioList = [];
  Future<Pet> _loadPet;
  Future<List> _loadRemedio;
  DateTime selectdDate = DateTime.now();
  String updatedDt;
  String horaTimer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("id: ${widget.id}");
    _loadPet = _getPet(widget.id);
    _loadRemedio = _getRemedios(widget.id);
    notificationManager.initialuzeNotificatios();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadPet,
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            widget.pet = asyncSnapshot.data;

            return Scaffold(
              appBar: AppBar(
                title: Text("Remédios do(a) ${widget.pet.nome}"),
              ),
              body: Center(
                child: Column(
                  children: <Widget>[
                    FutureBuilder(
                        future: _loadRemedio,
                        builder: (BuildContext context,
                            AsyncSnapshot asyncSnapshot) {
                          if (asyncSnapshot.hasData) {
                            remedioList = asyncSnapshot.data;

                            return Expanded(
                              child: ListView.builder(
                                  padding: EdgeInsets.all(10),
                                  itemCount: remedioList.length,
                                  itemBuilder: (context, index) {
                                    final item = remedioList[index];
                                    print("remedios: ${item.nome}");
                                    _selectedDate(
                                        remedioList[index].inicioData);
                                    _selectedHora(remedioList[index].hora);
                                    _sheduleDailyNotifications(
                                        remedioList[index].hora,
                                        remedioList[index].inicioData,
                                        remedioList[index].nome,
                                        widget.pet.nome);
                                    return Card(
                                      key: Key(item.id.toString()),
                                      shadowColor:
                                          widget.cor == 0 || widget.cor == null
                                              ? Colors.black
                                              : Colors.green[900],
                                      elevation: 10.0,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: ListTile(
                                                  leading: Icon(Icons.healing,
                                                      color: Colors.red),
                                                  title: Text(
                                                    remedioList[index].nome,
                                                    style: TextStyle(
                                                        decoration:
                                                            widget.teste,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red),
                                                  ),
                                                  subtitle: Text(
                                                    updatedDt =
                                                        "${updatedDt} -  ${horaTimer}",
                                                    style: TextStyle(
                                                        decoration:
                                                            widget.teste,
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 12,
                                                        color: Colors.red),
                                                    maxLines: 10,
                                                  ),
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetalheRemedioScreen(
                                                                  id: remedioList[
                                                                          index]
                                                                      .id,
                                                                  pet: widget
                                                                      .pet)),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            );
                          } else if (asyncSnapshot.hasError) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          } else {
                            return Center(
                              child: Text("Este pet não possui remédios"),
                            );
                          }
                        }),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormRemedioPetScreen(
                        id: widget.pet.id_pet,
                      ),
                    ),
                  );
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.redAccent,
              ),
              // floatingActionButtonLocation:
              //     FloatingActionButtonLocation.centerDocked,
              // bottomNavigationBar: NavNarRemedio(
              //   pet: widget.pet,
              //   paginaAberta: 1,
              // ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<Pet> _getPet(int id) async {
    return await petService.getPet(id);
  }

  Future<List> _getRemedios(int id) async {
    return await remedioService.getRemedioPets(id);
  }

  Future<void> _selectedDate(String dateRem) async {
    String strDt = dateRem;
    DateTime parseDt = DateTime.parse(strDt);
    var newFormat = DateFormat("dd/MM/yyyy");

    if (dateRem != null) {
      updatedDt = newFormat.format(parseDt);
    }
  }

  Future<void> _selectedHora(String horaRem) async {
    if (horaRem != null) {
      horaTimer = horaRem;
    }
  }

  void _showNotificationAgenda(
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

  void _showNotificationAgendaTeste(
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

  void _sheduleDailyNotifications(
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

  void _agenda(
      String horaRemedio, String dataRemedio, String nome, String pet) {
    int hora = int.parse(horaRemedio.substring(0, 2));
    int miniute = int.parse(horaRemedio.substring(3, 5));
    String strDt = dataRemedio;
    DateTime parseDt = DateTime.parse(strDt);
    var newFormat = DateFormat("dd/MM/yyyy");
    String dateRemedioFinal = newFormat.format(parseDt);
    notificationManager.agendaNT(hora, miniute, dateRemedioFinal, nome, pet);
  }

  void _showPeriodos(
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
