import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lifepet_app/helpers/notifications_manager.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/models/remedio_model.dart';
import 'file:///C:/Users/jt/Desktop/Projetos/perfilPet-master/lib/screens/remedio/components/form_remedio_pet_screen.dart';
import 'package:lifepet_app/services/pet_service.dart';
import 'package:lifepet_app/services/remedio_service.dart';
import 'package:lifepet_app/components/custom_navbar.dart';
import 'package:intl/intl.dart';

class RemedioScreen extends StatefulWidget {
  int id;
  int cor = 0;

  var teste = TextDecoration.none;
  var textoButton = '"Concluir"';
  var iconButton = Icons.close;
  var corButton = 0;

  RemedioScreen(
      {this.id,
      this.cor,
      this.teste,
      this.textoButton,
      this.iconButton,
      this.corButton});

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
  Pet pet;
  Future<Pet> _loadPet;
  Future<List> _loadRemedio;
  DateTime selectdDate = DateTime.now();
  String updatedDt;
  String horaTimer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
            pet = asyncSnapshot.data;

            return Scaffold(
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Hero(
                          tag: pet.id_pet,
                          child: Container(
                            width: double.infinity,
                            height: 350,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(pet.imageURL),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40, left: 10),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.arrow_back_ios),
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                                    _selectedDate(remedioList[index].data);
                                    _selectedHora(remedioList[index].hora);
                                   // _showNotificationAgenda(remedioList[index].hora, remedioList[index].data, remedioList[index].nome, pet.nome);
                                   _sheduleDailyNotifications(remedioList[index].hora, remedioList[index].data, remedioList[index].nome, pet.nome);
                                   //_showPeriodos(remedioList[index].hora, remedioList[index].data, remedioList[index].nome, pet.nome);
                                   // _showNotificationAgendaTeste(remedioList[index].hora, remedioList[index].data, remedioList[index].nome, pet.nome);
                                   // _agenda(remedioList[index].hora, remedioList[index].data, remedioList[index].nome, pet.nome);

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
                                                      color: remedioList[index]
                                                                      .id ==
                                                                  index ||
                                                              widget.cor == null
                                                          ? Colors.red
                                                          : Colors.green[900]),
                                                  title: Text(
                                                    remedioList[index].nome,
                                                    style: TextStyle(
                                                        decoration: widget.teste,
                                                        fontFamily: "Montserrat",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: widget.cor ==
                                                                    0 ||
                                                                widget.cor ==
                                                                    null
                                                            ? Colors.red
                                                            : Colors
                                                                .green[900]),
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
                                                        color: widget.cor ==
                                                                    0 ||
                                                                widget.cor ==
                                                                    null
                                                            ? Colors.red
                                                            : Colors
                                                                .green[900]),
                                                    maxLines: 10,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: FlatButton.icon(
                                                  minWidth: 10,
                                                  textColor: Colors.black,
                                                  color: widget.corButton ==
                                                              0 ||
                                                          widget.corButton ==
                                                              null
                                                      ? Colors.amber[200]
                                                      : Colors.greenAccent[400],
                                                  onPressed: () {
                                                    setState(() {
                                                      if (item.id.toString() ==
                                                          item.id.toString()) {
                                                        print(
                                                            "item.id.toString() ${item.id.toString()}");
                                                        if (item.id
                                                                .toString() ==
                                                            item.id
                                                                .toString()) {
                                                          widget.corButton ==
                                                                      0 ||
                                                                  widget.corButton ==
                                                                      null
                                                              ? widget
                                                                  .corButton = 1
                                                              : widget
                                                                  .corButton = 0;
                                                        }
                                                      }
                                                      // widget.corButton == 0 ||
                                                      //    widget.corButton == null
                                                      //    ? widget.corButton = 1
                                                      //    : widget.corButton = 0;
                                                      // widget.corButton == 0
                                                      //     ? widget.cor = 0
                                                      //     : widget.cor = 1;
                                                      // widget.corButton == 0
                                                      //     ? widget.teste =
                                                      //     TextDecoration.lineThrough
                                                      //     : widget.teste = TextDecoration.none;
                                                      // widget.corButton == 0
                                                      //     ? widget.textoButton = 'Concluido'
                                                      //     : widget.textoButton = 'Concluir';
                                                    });
                                                  },
                                                  icon: Icon(
                                                    widget.corButton == 1
                                                        ? widget.iconButton =
                                                            Icons.check_circle
                                                        : widget.iconButton =
                                                            Icons.close,
                                                    size: 15,
                                                  ),
                                                  label: Text(widget
                                                              .textoButton ==
                                                          null
                                                      ? 'Concluir'
                                                      : '${widget.textoButton}'),
                                                ),
                                              )
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
                        id: pet.id_pet,
                      ),
                    ),
                  );
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.redAccent,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: CustomNavbar(
                pet: pet,
                paginaAberta: 1,
              ),

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

  void _showNotificationAgenda(String horaRemedio, String dataRemedio, String nome, String pet) {

    String strDt = dataRemedio;
    DateTime parseDt = DateTime.parse(strDt);
    var newFormat = DateFormat("dd/MM/yyyy");
    var now = new DateTime.now();

    int hora = int.parse(horaRemedio.substring(0,2));
    int miniute = int.parse(horaRemedio.substring(3,5));
    String horaFinal = "${hora}:${miniute}";

    String horaNow = "${now.hour}:${now.minute}";
    String dateRemedioTeste  = newFormat.format(parseDt);
    String dateRemedioNow  = newFormat.format(now);

    print("horaNow: ${horaNow}");
    print("horaFinal: ${horaFinal}");
    print("dateRemedioTeste: ${dateRemedioTeste}");
    print("dateRemedioNow: ${dateRemedioNow}");

    if(horaNow ==  horaFinal && dateRemedioTeste == dateRemedioNow){
      print("horaFinal if: ${horaFinal}");
    }
    if (dataRemedio != null) {
     notificationManager.showNotificationsAgenda(hora,miniute,dataRemedio, nome, pet);

    }
  }
  void _showNotificationAgendaTeste(String horaRemedio, String dataRemedio, String nome, String pet) {

    String strDt = dataRemedio;
    DateTime parseDt = DateTime.parse(strDt);
    var newFormat = DateFormat("dd/MM/yyyy");
    var now = new DateTime.now();

    int hora = int.parse(horaRemedio.substring(0,2));
    int miniute = int.parse(horaRemedio.substring(3,5));
    String horaFinal = "${hora}:${miniute}";

    String horaNow = "${now.hour}:${now.minute}";
    String dateRemedioTeste  = newFormat.format(parseDt);
    String dateRemedioNow  = newFormat.format(now);

    if(horaNow ==  now && dateRemedioTeste == dateRemedioNow && dataRemedio != null){
     notificationManager.showNotificationsAgendaTeste(hora,miniute,dateRemedioTeste, nome, pet);
    }
    if (dataRemedio != null) {
      updatedDt = newFormat.format(parseDt);
    }

  }
  void _sheduleDailyNotifications(String horaRemedio, String dataRemedio, String nome, String pet){
    int hora = int.parse(horaRemedio.substring(0,2));
    int miniute = int.parse(horaRemedio.substring(3,5));
    String strDt = dataRemedio;
    DateTime parseDt = DateTime.parse(strDt);
    var newFormat = DateFormat("dd/MM/yyyy");
    String dateRemedioFinal = newFormat.format(parseDt);
      notificationManager.sheduleDailyNotifications(hora,miniute,dateRemedioFinal, nome, pet);

  }
  void _agenda(String horaRemedio, String dataRemedio, String nome, String pet){
    int hora = int.parse(horaRemedio.substring(0,2));
    int miniute = int.parse(horaRemedio.substring(3,5));
    String strDt = dataRemedio;
    DateTime parseDt = DateTime.parse(strDt);
    var newFormat = DateFormat("dd/MM/yyyy");
    String dateRemedioFinal = newFormat.format(parseDt);
      notificationManager.agendaNT(hora,miniute,dateRemedioFinal, nome, pet);

  }

  void _showPeriodos(String horaRemedio, String dataRemedio, String nome, String pet){
    int hora = int.parse(horaRemedio.substring(0,2));
    int miniute = int.parse(horaRemedio.substring(3,5));
    String strDt = dataRemedio;
    DateTime parseDt = DateTime.parse(strDt);
    var newFormat = DateFormat("dd/MM/yyyy");
    String dateRemedioFinal = newFormat.format(parseDt);
      notificationManager.showNotificationsAgendaPeriodo(hora,miniute,dateRemedioFinal, nome, pet);

  }

}
