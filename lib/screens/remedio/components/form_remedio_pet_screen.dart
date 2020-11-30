import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/models/remedio_model.dart';
import 'file:///C:/Users/jt/Desktop/Projetos/perfilPet-master/lib/screens/remedio/remedio_screen.dart';
import 'package:lifepet_app/services/pet_service.dart';
import 'package:lifepet_app/services/remedio_service.dart';

class FormRemedioPetScreen extends StatefulWidget {
  int id;

  FormRemedioPetScreen({this.id});

  @override
  _FormRemedioPetScreenState createState() => _FormRemedioPetScreenState();
}

class _FormRemedioPetScreenState extends State<FormRemedioPetScreen> {
  final _nomeControler = TextEditingController();
  final _inicioDataControler = TextEditingController();
  final _fimDataControler = TextEditingController();
  final _timeControler = TextEditingController();
  final _descricaoControler = TextEditingController();
  final PetService petService = PetService();
  final RemedioService remedioService = RemedioService();

  Pet pet;
  Future<Remedio> _loadremedio;
  Future<Pet> _loadPet;
  DateTime _selectdDateInicio = DateTime.now();
  DateTime _selectdDateFim = DateTime.now();
  TimeOfDay _selectdTime = new TimeOfDay.now();
  DateTime _dateInicio;
  DateTime _dateFim;
  String timerFinal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPet = _getPet(widget.id);
    _loadPet.then((value) => pet = value);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadPet,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        pet = snapshot.data;
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Cadastro de remédio do pet:  ${pet.nome}"),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      controller: _nomeControler,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: "Nome do remédio"),
                    ),
                    GestureDetector(
                      onTap: () => _selectedDateInicio(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _inicioDataControler,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              labelText: _selectdDateInicio.toString()),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _selectedDateFim(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _fimDataControler,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              labelText: _selectdDateFim.toString()),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _selectedTime(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _timeControler,
                          keyboardType: TextInputType.text,
                          decoration:
                              InputDecoration(labelText: timerFinal.toString()),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _descricaoControler,
                      keyboardType: TextInputType.text,
                      decoration:
                          InputDecoration(labelText: "Descrição do remédio"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Container(
                        height: 40,
                        child: RaisedButton(
                          onPressed: () {
                            Remedio novoRemedio = Remedio(
                                nome: _nomeControler.text,
                                inicioData: _selectdDateInicio.toString(),
                                fimData: _selectdDateFim.toString(),
                                descricao: _descricaoControler.text,
                                hora: timerFinal.toString(),
                                pet: pet.id_pet);

                            remedioService.addRemedio(novoRemedio);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => RemedioScreen(id: pet.id_pet),
                              ),
                            );
                          },
                          color: Colors.redAccent,
                          child: Text(
                            "Cadastrar",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
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

  Future<Pet> _getPet(int id) async {
    return await petService.getPet(id);
  }

  Future<void> _selectedDateInicio(BuildContext context) async {
    final DateTime dataSelecionadaIncio = await showDatePicker(
        context: context,
        initialDate: _selectdDateInicio,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime(2050));
    if (dataSelecionadaIncio != null &&
        dataSelecionadaIncio != _selectdDateInicio) {
      setState(() {
        _selectdDateInicio = dataSelecionadaIncio;
      });
    }
  }

  Future<void> _selectedDateFim(BuildContext context) async {
    final DateTime dataSelecionada = await showDatePicker(
        context: context,
        initialDate: _selectdDateFim,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime(2050));

    if (dataSelecionada != null && dataSelecionada != _selectdDateFim) {
      setState(() {
        _selectdDateFim = dataSelecionada;
      });
    }
  }

  Future<Null> _selectedTime(BuildContext context) async {
    final TimeOfDay _times =
        await showTimePicker(context: context, initialTime: _selectdTime);
    final String str = _times.toString();
    final String start = "TimeOfDay(";
    final String end = ")";

    final startIndex = str.indexOf(start);
    final endIndex = str.indexOf(end, startIndex + start.length);
    final String _timesFinal =
        str.substring(startIndex + start.length, endIndex);

    if (_times != _selectdTime && _times != null) {
      setState(() {
        timerFinal = _timesFinal;
      });
    }
  }
}
