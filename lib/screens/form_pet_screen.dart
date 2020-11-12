import 'package:flutter/material.dart';
import 'package:lifepet_app/screens/home_screens.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/services/pet_service.dart';

class FormPetScreen extends StatefulWidget {
  Pet newPet;
  PetService petService = PetService();
  @override
  _FormPetScreenState createState() => _FormPetScreenState();
}

class _FormPetScreenState extends State<FormPetScreen> {
  String corPet = 'Branco';
  String sexoPet = 'Macho';

  final _nomeControler = TextEditingController();
  final _bioControler = TextEditingController();
  final _idadeControler = TextEditingController();
  final _descricaoControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Pet newPet;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Pet"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _nomeControler,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Nome do pet"),
                ),
                TextFormField(
                  controller: _bioControler,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Bio"),
                ),
                TextFormField(
                  controller: _idadeControler,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Idade"),
                ),
                DropdownButtonFormField(
                  value: sexoPet,
                  onChanged: (String sexoSelecionado) {
                    setState(() {
                      sexoPet = sexoSelecionado;
                    });
                  },
                  items: <String>['Macho', 'Femea']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                TextFormField(
                  controller: _descricaoControler,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Descricao"),
                ),
                DropdownButtonFormField(
                  value: corPet,
                  onChanged: (String corSelecionada) {
                    setState(() {
                      corPet = corSelecionada;
                    });
                  },
                  items: <String>['Branco', 'Preto', 'Marrom', 'Amarelo']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () => {
                        newPet = Pet(
                            nome: _nomeControler.text,
                            bio: _bioControler.text,
                            idade: int.parse(_idadeControler.text),
                            sexo: sexoPet,
                            descricao: _descricaoControler.text,
                            cor: corPet),
                            widget.petService.addPet(newPet),
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => HomeScreen())
                        ),
                      },

                      color: Colors.redAccent,
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      color: Colors.redAccent,
                      child: Text(
                        "Voltar",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
