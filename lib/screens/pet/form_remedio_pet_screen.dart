import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/models/remedio_model.dart';
import 'package:lifepet_app/screens/pet/remedio_screen.dart';
import 'package:lifepet_app/services/pet_service.dart';
import 'package:lifepet_app/services/remedio_service.dart';

class FormRemedioPetScreen extends StatelessWidget {
  int id;
  final _nomeControler = TextEditingController();
  final _dataControler = TextEditingController();
  final PetService petService = PetService();
  final RemedioService remedioService = RemedioService();
  Pet pet;

  FormRemedioPetScreen({this.id}) {
    _getPet(this.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de remédio ${pet.nome}"),
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
              TextFormField(
                controller: _dataControler,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(labelText: "Data do remédio "),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Container(
                  height: 40,
                  child: RaisedButton(
                    onPressed: () {
                      Remedio novoRemedio = Remedio(
                          nome: _nomeControler.text,
                          data: _dataControler.text,
                          pet: pet);
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
  }

  void _getPet(int id) {
    pet = petService.getPet(id);
  }
}
