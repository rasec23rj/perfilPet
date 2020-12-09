import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lifepet_app/helpers/notifications_manager.dart';
import 'package:lifepet_app/models/foto_remedio.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/models/remedio_model.dart';
import 'package:lifepet_app/screens/remedio/components/form_foto_remedio.dart';
import 'package:lifepet_app/screens/remedio/components/remedio_card.dart';
import 'package:lifepet_app/services/foto_remedio_service.dart';
import 'file:///C:/Users/jt/Desktop/Projetos/perfilPet-master/lib/screens/remedio/components/form_remedio_pet_screen.dart';
import 'package:lifepet_app/services/pet_service.dart';
import 'package:lifepet_app/services/remedio_service.dart';
import 'package:lifepet_app/screens/remedio/components/detalhe_remedio.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

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
  List<Remedio> remedioList = List();

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

  @override
  void initState() {
    super.initState();
    notificationManager.initialuzeNotificatios();
    setState(() {
      _loadPet = _getPet(widget.id);
      _loadRemedio = _getRemedios(widget.id);
      print("state incio: ${widget.id}");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder(
          future: _loadPet,
          builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
            print("asyncSnapshot.hasData: ${asyncSnapshot.hasData}");
            if (asyncSnapshot.hasData) {
              widget.pet = asyncSnapshot.data;

              return Scaffold(
                appBar: AppBar(
                  title: Text("Remédios do(a) ${widget.pet.nome}"),
                ),
                body: remedioCard(context, _loadRemedio, widget.pet),
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

  Future<Pet> _getPet(int id) async {
    return await petService.getPet(id);
  }

  Future<List> _getRemedios(int id) async {
    return await remedioService.getRemedioPets(id);
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


}
