import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/models/remedio_model.dart';
import 'package:lifepet_app/services/pet_service.dart';
import 'package:lifepet_app/services/remedio_service.dart';

class DetalheRemedioScreen extends StatefulWidget {
  int id;
  Pet pet;

  DetalheRemedioScreen({this.id, this.pet});

  @override
  _DetalheRemedioScreenState createState() => _DetalheRemedioScreenState();
}

class _DetalheRemedioScreenState extends State<DetalheRemedioScreen> {
  final _nomeControler = TextEditingController();
  final _dataControler = TextEditingController();
  final _timeControler = TextEditingController();
  final PetService petService = PetService();
  final RemedioService remedioService = RemedioService();
  String nomePet;
  Remedio remedios;
  Future<Remedio> _loadremedio;
  String updatedDtIncio;
  String updatedDtFim;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadremedio = _getRemedios(widget.id);
    nomePet = widget.pet.nome;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadremedio,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        remedios = snapshot.data;

        if (snapshot.hasData) {
          _selectedDate(remedios.inicioData, remedios.fimData);
          return Scaffold(
              appBar: AppBar(
                title: Text("Remédio do(a):  ${nomePet}"),
              ),
              body: ListView(
                children: <Widget>[
                  Flexible(
                      flex: 1,
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(
                                    Icons.healing,
                                    size: 50,
                                  ),
                                  title: Text('Nome: ${remedios.nome}'),
                                  subtitle: Text(
                                      'Incio: ${updatedDtIncio} \t\r\n Fim: ${updatedDtIncio}\t\r\n Hora: ${remedios.hora}\t\r\n Descrição: ${remedios.descricao}'),
                                ),
                              ],
                            ),
                          ))),
                  Flexible(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Teste2',
                          style: TextStyle(color: Colors.red, fontSize: 24),
                        ),
                      )),
                ],
              ));
        } else if (snapshot.hasError) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.redAccent,
            ),
          );
        } else {
          return Text("");
        }
      },
    );
  }

  Future<Remedio> _getRemedios(int id) async {
    return await remedioService.getRemedio(id);
  }

  Future<void> _selectedDate(String inicio, String fim) async {
    String strDtInicio = inicio;
    DateTime parseDt = DateTime.parse(strDtInicio);
    String fimData = fim;
    DateTime parseDtFim = DateTime.parse(fimData);
    var newFormat = DateFormat("dd/MM/yyyy");
    setState(() {
      if (inicio != null && fim != null) {
        updatedDtIncio = newFormat.format(parseDt);
        updatedDtFim = newFormat.format(parseDtFim);
        print("updatedDtIncio: ${updatedDtIncio}");
        print("updatedDtFim: ${updatedDtFim}");
      }
    });
  }
}
