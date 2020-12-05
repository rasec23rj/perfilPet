import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lifepet_app/helpers/notifications_manager.dart';
import 'package:lifepet_app/models/foto_remedio.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/models/remedio_model.dart';
import 'package:lifepet_app/services/foto_remedio_service.dart';
import 'file:///C:/Users/jt/Desktop/Projetos/perfilPet-master/lib/screens/remedio/components/form_remedio_pet_screen.dart';
import 'package:lifepet_app/services/pet_service.dart';
import 'package:lifepet_app/services/remedio_service.dart';
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
  NotificationManager notificationManager = NotificationManager();
  var texto = '0';
  final PetService petService = PetService();
  final RemedioService remedioService = RemedioService();
  FotoRemedioService fotoRemedioService = FotoRemedioService();
  List<Remedio> remedioList = [];
  //List<FotoRemedio> remedioFotoList = [];
  Future<Pet> _loadPet;
  Future<List> _loadRemedio;
  DateTime selectdDate = DateTime.now();
  String updatedDt;
  String updatedDtFinal;
  String horaTimer;
  Future<List> _loadFotoRemedio;
  File _image;
  int _counter = 0;
  List<FotoRemedio> remedioFotoList = List();
  @override
  void initState() {
    super.initState();
    _loadPet = _getPet(widget.id);
    _loadRemedio = _getRemedios(widget.id);
    _loadRemedio.then((value) => fotos(value));
    notificationManager.initialuzeNotificatios();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder(
          future: _loadPet,
          builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              widget.pet = asyncSnapshot.data;

              return Scaffold(
                appBar: AppBar(
                  title: Text("Remédios do(a) ${widget.pet.nome}"),
                ),
                body: Cards(),
                //
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
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget Cards() {
    return Center(
      child: Column(
        children: <Widget>[
          FutureBuilder(
              future: _loadRemedio,
              builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  remedioList = asyncSnapshot.data;

                  return Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: remedioList.length,
                        itemBuilder: (context, index) {
                          final item = remedioList[index];
                          _selectedDate(remedioList[index].inicioData,
                              remedioList[index].fimData);
                          _selectedHora(remedioList[index].hora);
                          _getFotoRemedios(remedioList[index].id);
                          _sheduleDailyNotifications(
                              remedioList[index].hora,
                              remedioList[index].inicioData,
                              remedioList[index].nome,
                              widget.pet.nome);
                          return Card(
                            key: Key(item.id.toString()),
                            shadowColor: Colors.transparent,
                            color: Colors.white,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: ListTile(
                                        leading: Ink(
                                          decoration: const ShapeDecoration(
                                            color: Colors.white,
                                            shape: CircleBorder(),
                                          ),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.healing,
                                              color: Colors.red,
                                            ),
                                            iconSize: 35,
                                            onPressed: () {
                                              _showFoto(
                                                  remedioList[index].id,
                                                  index,
                                                  remedioList[index].nome);
                                            },
                                          ),
                                        ),
                                        title: Text(
                                          remedioList[index].nome,
                                          style: TextStyle(
                                            decoration: widget.teste,
                                            fontFamily: "Montserrat",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(
                                          " Data inicio: ${updatedDt}\n\tData fim: ${updatedDtFinal}\n\tHorario: ${horaTimer}\n\tDescrição: ${remedioList[index].descricao} ",
                                          style: TextStyle(
                                              decoration: widget.teste,
                                              fontFamily: "Montserrat",
                                              fontSize: 12,
                                              color: Colors.red),
                                          maxLines: 10,
                                        ),
                                        trailing: Ink(
                                          decoration: const ShapeDecoration(
                                            color: Colors.white,
                                            shape: CircleBorder(),
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.more_vert),
                                            iconSize: 30,
                                            onPressed: () {
                                              _showDescricao();
                                            },
                                          ),
                                        ),
                                        isThreeLine: true,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetalheRemedioScreen(
                                                        id: remedioList[index]
                                                            .id,
                                                        pet: widget.pet)),
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
    );
  }

  Future<Pet> _getPet(int id) async {
    return await petService.getPet(id);
  }

  Future<List> _getRemedios(int id) async {
    return await remedioService.getRemedioPets(id);
  }

  Future<void> _selectedDate(String dateRem, String dataFim) async {
    DateTime parseDt = DateTime.parse(dateRem);
    DateTime parseDtFinal = DateTime.parse(dataFim);
    var newFormat = DateFormat("dd/MM/yyyy");

    if (dateRem != null) {
      updatedDt = newFormat.format(parseDt);
      updatedDtFinal = newFormat.format(parseDtFinal);
    }
  }

  Future<void> _selectedHora(String horaRem) async {
    if (horaRem != null) {
      horaTimer = horaRem;
    }
  }

  Future<void> _showDescricao() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showFoto(IdRemedio, index, remedio) async {
    _loadFotoRemedio = _getFotoRemedios(IdRemedio);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Imagens  do remédio ${remedio}'),
          content: SingleChildScrollView(
            child: FutureBuilder(
                future: _loadFotoRemedio,
                builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                  if (asyncSnapshot.hasData) {
                    remedioFotoList = asyncSnapshot.data;
                    return Container(
                      padding: EdgeInsets.all(1),
                      child: Grid(remedioFotoList, index),
                    );
                  } else if (asyncSnapshot.hasError) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("Este pet não possui foto de  remédios"),
                    );
                  }
                }),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Sair'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget Grid(remedioFotoList, index) {
    return remedioFotoList[index].nome == null
        ? Image.asset('assets/images/pet.png')
        : Image.file(
            File(remedioFotoList[index].nome),
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
            width: 100.0,
            height: 100.0,
          );
  }

  Future<List> _getFotoRemedios(int id) async {
    return await fotoRemedioService.getFotoRemedio(id);
  }

  Future<List> fotos(valores) async {
    setState(() {
      // _loadFotoRemedio = _getFotoRemedios(value.);
      print("valores: ${valores}");
    });
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
