import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifepet_app/models/foto_remedio.dart';
import 'package:lifepet_app/screens/remedio/components/form_foto_remedio.dart';
import 'package:lifepet_app/screens/remedio/remedio_controller.dart';
import 'package:lifepet_app/screens/remedio/remedios_bloc.dart';
import 'package:lifepet_app/services/remedio_service.dart';
import 'package:provider/provider.dart';

RemedioBloc remedioBloc = RemedioBloc();
File image;
final picker = ImagePicker();

Widget slideShow(context, remedioFotoList, index, remedio, idRemedio, pet) {
  RemedioService remedioService = RemedioService();
  RemedioController remedioController = Provider.of<RemedioController>(context);

  return Scaffold(
    body: Builder(
      builder: (context) {
        if (remedioFotoList.length != 0) {
          return Stack(
            children: <Widget>[
              Consumer<RemedioController>(
                  builder: (context, RemedioController, widget2) {
                return Hero(
                  tag: remedioFotoList[index].id,
                  child: StreamBuilder(
                      stream: remedioBloc.output,
                      builder: (context, snapshot) {
                        print("snapshot: ${snapshot.data}");
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          width: double.infinity,
                          child: Column(
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                    height: MediaQuery.of(context).size.height /
                                        1.2,
                                    viewportFraction: 1.0,
                                    enlargeCenterPage: true,
                                    aspectRatio: 2.0,
                                    onPageChanged: (index, reason) {
                                      remedioController.current =
                                          RemedioController.carrosel(index);
                                      remedioController.deleteFotoShowId(
                                          remedioFotoList[index].id,
                                          remedioFotoList[index].nome);
                                    }
                                    // autoPlay: false,
                                    ),
                                items: remedioFotoList
                                    .map<Widget>(
                                      (item) => Container(
                                        child: item.nome == null
                                            ? Image.asset(
                                                'assets/images/pet.png')
                                            : Image.file(
                                                File(item.nome),
                                                fit: BoxFit.fitHeight,
                                                alignment: Alignment.center,
                                                width: double.infinity,
                                                height: 350.0,
                                              ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: remedioFotoList.map<Widget>((url) {
                                  int indexSlide = remedioFotoList.indexOf(url);

                                  return Wrap(
                                    children: [
                                      Container(
                                        width: 8.0,
                                        height: 15.0,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 2.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: RemedioController.current ==
                                                  indexSlide
                                              ? Colors.redAccent
                                              : Color.fromRGBO(0, 0, 0, 0.4),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        );
                      }),
                );
              }),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40, left: 10),
                    child: Material(
                      color: Colors.transparent,
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.redAccent,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 40,
                        left: MediaQuery.of(context).size.width / 1.5,
                        right: 0),
                    child: Material(
                      color: Colors.transparent,
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.redAccent,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.delete_rounded),
                          color: Colors.white,
                          onPressed: () {
                            remedioService.deleteFotoRemedios(
                                remedioController.idFotoRemedio,
                                remedioController.nomeFotoRemedio);
                            Navigator.of(context)
                                .pushReplacementNamed('/slideShow');
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        } else {
          return Container(
            alignment: Alignment.center,
            child: Text("Sem foto do remédio",
                style: TextStyle(color: Colors.redAccent, fontSize: 25)),
          );
        }
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        if (idRemedio != null) {
          _cadastroFotoRemedio(context, idRemedio);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormFotoRemedioScreen(
                id: remedioFotoList[index].id,
                pet: pet,
              ),
            ),
          );
        }
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.redAccent,
    ),
  );
}

Future<void> _cadastroFotoRemedio(context, idRemedio) async {
  remedioBloc.getFotoRemedio(idRemedio);
  FotoRemedio newFotoRemedio;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(1),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1),
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: StreamBuilder(
                                stream: remedioBloc.outputFoto,
                                builder: (context, snapshot) {
                                  return Center(
                                    child: snapshot.data == null
                                        ? Image.asset('assets/images/pet.png')
                                        : Image.file(
                                            File(snapshot.data.toString()),
                                            fit: BoxFit.fitHeight,
                                            //alignment: Alignment.center,
                                            // width: 250.0,
                                            // height:  250.0,
                                          ),
                                  );
                                }),
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
                      child: Row(
                        children: [
                          RaisedButton(
                            onPressed: () => {
                              newFotoRemedio = FotoRemedio(
                                  nome: remedioBloc.nomeControler.text,
                                  remedios: idRemedio),
                              remedioBloc.fotoRemedioService
                                  .addFotoRemedio(newFotoRemedio),
                              remedioBloc.input.add(idRemedio),
                              Navigator.pop(context)
                            },
                            color: Colors.redAccent,
                            child: Text(
                              "Salvar ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          Spacer(flex: 1,),
                          RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Colors.black,
                            child: Text(
                              "Sair ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Future getImage() async {
  var pickedFile = await picker.getImage(source: ImageSource.camera);
  remedioBloc.setImage(pickedFile);
}
