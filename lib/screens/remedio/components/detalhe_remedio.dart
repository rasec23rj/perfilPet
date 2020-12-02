import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifepet_app/models/foto_remedio.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/models/remedio_model.dart';
import 'package:lifepet_app/screens/remedio/components/form_foto_remedio.dart';
import 'package:lifepet_app/services/foto_remedio_service.dart';
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
  final PetService petService = PetService();
  final RemedioService remedioService = RemedioService();
  FotoRemedioService fotoRemedioService = FotoRemedioService();
  String nomePet;
  Remedio remedios;
  FotoRemedio fotoRemedio;
  List<FotoRemedio> remedioList = [];
  Future<Remedio> _loadremedio;
  Future<List> _loadFotoRemedio;
  String updatedDtIncio;
  String updatedDtFim;
  File _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _loadremedio = _getRemedios(widget.id);
      _loadFotoRemedio = _getFotoRemedios(widget.id);

      nomePet = widget.pet.nome;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadremedio,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        remedios = snapshot.data;

        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Remédio do(a):  ${nomePet}"),
            ),
            body: Center(
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Remedios(),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      height: 450.0,
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: FutureBuilder(
                          future: _loadFotoRemedio,
                          builder: (BuildContext context,
                              AsyncSnapshot asyncSnapshot) {
                            if (asyncSnapshot.hasData) {
                              remedioList = asyncSnapshot.data;
                              final orientation =
                                  MediaQuery.of(context).orientation;
                              return Expanded(
                                child: Grid(orientation),
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
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormFotoRemedioScreen(
                      id: remedios.id,
                      pet: widget.pet,
                    ),
                  ),
                );
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.redAccent,
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

  Future<Remedio> _getRemedios(int id) async {
    return await remedioService.getRemedio(id);
  }

  Future<List> _getFotoRemedios(int id) async {
    return await fotoRemedioService.getFotoRemedio(id);
  }

  Future<void> _deleteFotoRemedios(int id) async {
    return await fotoRemedioService.deleteFotoRemedio(id);
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

  Widget Grid(orientation) {
    return GridView.builder(
        itemCount: remedioList.length,
        padding: EdgeInsets.all(5),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (orientation == Orientation.portrait) ? 3 : 4),
        itemBuilder: (BuildContext context, int index) {
          final item = remedioList[index];
          return Wrap(
            spacing: 10.0,
            runSpacing: 50.0, // gap between adjacent chips

            children: <Widget>[
              InkWell(
                onTap: () {
                  _showMyDialog(context, item);
                  // createNewMessage(context, item);
                },
                child: item.nome == null
                    ? Text('No image selected.')
                    : Image.file(
                        File(item.nome),
                        alignment: Alignment.center,
                        width: 220,
                        height: 180,
                        fit: BoxFit.scaleDown,
                      ),
              ),
              Spacer(
                flex: 1,
              )
            ],
          );
        });
  }

  Widget Remedios() {
    _selectedDate(remedios.inicioData, remedios.fimData);
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }

  Future<void> _showMyDialog(context, item) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SizedBox(
          width: double.maxFinite,
          height: double.infinity,
          child: AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            content: Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(1),
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      padding: EdgeInsets.all(0),
                      child: item.nome == null
                          ? Text('No image selected.')
                          : Image.file(
                              File(item.nome),
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.fitHeight,
                              width: double.maxFinite,
                              height: double.infinity,
                            ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40, left: 10),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  child: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _deleteFotoRemedios(item.id).then((value) {
                      File tempLocalFile = File(item.nome);
                      if (tempLocalFile.existsSync()) {
                        // delete file
                        tempLocalFile.delete(
                          recursive: true,
                        );
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalheRemedioScreen(
                            id: remedios.id,
                            pet: widget.pet,
                          ),
                        ),
                      );
                    });
                  }),
            ],
          ),
        );
      },
    );
  }

  createNewMessage(context, item) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return WillPopScope(
                onWillPop: () {
                  return Future.value(true);
                },
                child: Material(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      width: double.infinity,
                      height: double.infinity,
                      child: SizedBox(
                        width: 300,
                        child: Stack(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(0),
                                child: Container(
                                  padding: EdgeInsets.all(0),
                                  child: item.nome == null
                                      ? Text('No image selected.')
                                      : Image.file(
                                          File(item.nome),
                                          filterQuality: FilterQuality.high,
                                          fit: BoxFit.fitHeight,
                                        ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 40, left: 10),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.arrow_back_ios),
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      )),
                ));
          },
        );
      },
    );
  }
}
