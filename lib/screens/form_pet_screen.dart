import 'package:flutter/material.dart';
import 'package:lifepet_app/screens/home_screens.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/services/pet_service.dart';

class FormPetScreen extends StatefulWidget {
  int id;

  FormPetScreen({this.id});

  @override
  _FormPetScreenState createState() => _FormPetScreenState();
}

class _FormPetScreenState extends State<FormPetScreen> {
  Pet pet;

  PetService petService = PetService();

  String corPet = 'Branco';
  String sexoPet = 'Macho';

  final _nomeControler = TextEditingController();
  final _bioControler = TextEditingController();
  final _idadeControler = TextEditingController();
  final _descricaoControler = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.id != -1) {
      _getPet(widget.id);
      _nomeControler.text = pet.nome;
      _bioControler.text = pet.bio;
      _idadeControler.text = pet.idade.toString();
      _descricaoControler.text = pet.descricao;
    }
  }

  @override
  Widget build(BuildContext context) {
    Pet newPet;
    return Scaffold(
      appBar: AppBar(
        title: Text(pet != null ? "Edição do Pet ": "Cadastro de Pet"),
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
                         pet != null ? petService.updatePet(pet.id_pet, newPet) :  petService.addPet(newPet),
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => HomeScreen())),
                      },
                      color: Colors.redAccent,
                      child: Text(
                        pet != null ? "Salvar ": "Cadastrar",
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

  void _getPet(int id) {
    pet = petService.getPet(id);
  }
}
