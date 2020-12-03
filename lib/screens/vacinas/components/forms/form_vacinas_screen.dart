import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/services/pet_service.dart';

class FormVacinaScreen extends StatefulWidget {
  int id;
  FormVacinaScreen({this.id});

  @override
  _FormVacinaScreenState createState() => _FormVacinaScreenState();
}

class _FormVacinaScreenState extends State<FormVacinaScreen> {
  Pet pet;
  DateTime _selectdDateInicio = DateTime.now();
  DateTime _selectdDateFim = DateTime.now();
  TimeOfDay _selectdTime = new TimeOfDay.now();
  DateTime _dateInicio;
  DateTime _dateFim;
  String timerFinal;
  Future<Pet> _loadPet;
  String nomePet;
  final PetService petService = PetService();

  @override
  void initState() {
    super.initState();
    _loadPet = _getPet(widget.id);
    _loadPet.then((value) => setImagem(value.nome));
    print("id: ${widget.id}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _loadPet,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          pet = snapshot.data;
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Vacina do(a): ${nomePet}"),
              ),
            );
          }
          ;
        },
      ),
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

  void setImagem(String nome) {
    setState(() {
      if (nome != null) {
        nomePet = nome;
      } else {
        print('No image selected.');
      }
    });
  }
}
