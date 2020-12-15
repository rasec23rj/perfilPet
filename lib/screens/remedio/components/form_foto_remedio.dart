import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/models/remedio_model.dart';
import 'package:lifepet_app/models/foto_remedio.dart';
import 'package:lifepet_app/screens/remedio/components/detalhe_remedio.dart';
import 'package:lifepet_app/screens/remedio/remedio_controller.dart';
import 'package:lifepet_app/screens/remedio/remedio_screen.dart';
import 'package:lifepet_app/services/foto_remedio_service.dart';
import 'package:provider/provider.dart';

class FormFotoRemedioScreen extends StatefulWidget {
  int id;
  Pet pet;

  FormFotoRemedioScreen({this.id, this.pet});

  @override
  _FormFotoRemedioState createState() => _FormFotoRemedioState();
}

class _FormFotoRemedioState extends State<FormFotoRemedioScreen> {
  Remedio remedio;
  FotoRemedio fotoRemedio;
  FotoRemedioService fotoRemedioService = FotoRemedioService();

  Future<FotoRemedio> _loadPet;

  final _nomeControler = TextEditingController();


  File _image;
  final picker = ImagePicker();


  @override
  void initState() {
    if (widget.id != -1) {
      _loadPet = _getFotoRemedio(widget.id);
      _loadPet.then((value) => {
            fotoRemedio = value,
            if (fotoRemedio != null)
              {
                _nomeControler.text = value.nome,
              }
          });
    }
    print("foto id: ${widget.id}");
    print("newFotoRemedio: ${widget.pet}");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FotoRemedio newFotoRemedio;
    RemedioController remedioController =
        Provider.of<RemedioController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de foto Remédio"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 10),
                          child: Center(
                            child: _image == null
                                ? Text('sem imagem')
                                : Image.file(
                                    _image != null
                                        ? _image
                                        : File(fotoRemedio.nome),
                                    fit: BoxFit.fitWidth,
                                    alignment: Alignment.center,
                                    width: 500.0,
                                    height: 350.0,
                                  ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 10),
                          child: IconButton(
                            onPressed: () {
                              getImage();
                            },
                            icon: Icon(
                              Icons.camera_alt_rounded,
                              size: 50,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ],
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
                        newFotoRemedio = FotoRemedio(
                            nome: _nomeControler.text, remedios: widget.id),
                        fotoRemedioService.addFotoRemedio(newFotoRemedio),
                        remedioController.reloadFotoRemedio(widget.id),
                        Navigator.pop(context)
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => RemedioScreen(
                        //           id: widget.id, pet: widget.pet)),
                        // ),
                      },
                      color: Colors.redAccent,
                      child: Text(
                        fotoRemedioService != null ? "Salvar " : "Cadastrar",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<FotoRemedio> _getFotoRemedio(int id) async {
    return await fotoRemedioService.getFotoRemedioFist(id);
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _nomeControler.text = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
  }
}
