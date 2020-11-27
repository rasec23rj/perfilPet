import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'file:///C:/Users/jt/Desktop/Projetos/perfilPet-master/lib/screens/home/home_screens.dart';
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
  String _corPet = 'Branco';
  String _sexoPet = 'Macho';
  Future<Pet> _loadPet;

  final _nomeControler = TextEditingController();
  final _bioControler = TextEditingController();
  final _idadeControler = TextEditingController();
  final _descricaoControler = TextEditingController();
  final _fotoController = TextEditingController();
  File _image;
  final picker = ImagePicker();
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    if (widget.id != -1) {
      _loadPet = _getPet(widget.id);
      _loadPet.then((value) => {
            pet = value,
            print("pet: ${pet}"),
            if (pet != null)
              {
                _nomeControler.text = value.nome,
                _bioControler.text = value.bio,
                _idadeControler.text = value.idade.toString(),
                _descricaoControler.text = value.descricao,
                _sexoPet = value.sexo,
                _corPet = value.cor,
              }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    Pet newPet;

    return Scaffold(
      appBar: AppBar(
        title: Text(pet != null ? "Edição do Pet " : "Cadastro de Pet"),
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
                  maxLength: 10,
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
                  value: _sexoPet,
                  onChanged: (String sexoSelecionado) {
                    setState(() {
                      _sexoPet = sexoSelecionado;
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
                  value: _corPet,
                  onChanged: (String corSelecionada) {
                    setState(() {
                      _corPet = corSelecionada;
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
                    height: 150.0,
                    width: 350,
                    color: Colors.white,
                    child: Center(
                      child: _image == null
                          ? Text('No image selected.')
                          : Image.file(_image),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () => {
                        newPet = Pet(
                            nome: _nomeControler.text,
                            bio: _bioControler.text,
                            idade: int.parse(_idadeControler.text),
                            sexo: _sexoPet,
                            descricao: _descricaoControler.text,
                            cor: _corPet,
                            imageURL: _fotoController.text),
                        //petService.addPet(newPet),
                        pet != null
                            ? petService.updatePet(pet.id_pet, newPet)
                            : petService.addPet(newPet),
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => HomeScreen())),
                      },
                      color: Colors.redAccent,
                      child: Text(
                        pet != null ? "Salvar " : "Cadastrar",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: () {
          getImage();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  Widget build2(BuildContext context) {
    TextEditingController _fotoController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Container(
              height: 280.0,
              color: Colors.white,
              child: Center(
                child: _image == null
                    ? Text('No image selected.')
                    : Image.file(_image),
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _fotoController,
              decoration: InputDecoration(
                  labelText: 'Nome da foto',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0))),
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              child: Text('Salvar'),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: () {
          getImage();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<Pet> _getPet(int id) async {
    return await petService.getPet(id);
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _fotoController.text = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
  }
}
