import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifepet_app/screens/remedio/components/form_foto_remedio.dart';
import 'package:lifepet_app/services/remedio_service.dart';

Widget slideShow(context, remedioFotoList, index, remedio, idRemedio, pet) { RemedioService remedioService = RemedioService();
  return Scaffold(
    body: Builder(
      builder: (context) {
        if (remedioFotoList.length != 0) {
          return Stack(
            children: <Widget>[
              Hero(
                tag: remedioFotoList[index].id,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      // autoPlay: false,
                    ),
                    items: remedioFotoList
                        .map<Widget>(
                          (item) => Container(
                              child: item.nome == null
                                  ? Image.asset('assets/images/pet.png')
                                  : Image.file(
                                      File(item.nome),
                                      fit: BoxFit.fitHeight,
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      height: double.infinity,
                                    )),
                        )
                        .toList(),
                  ),
                ),
              ),
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
                            remedioService
                                .deleteFotoRemedios(remedioFotoList[index].id)
                                .then(
                              (value) {
                                File tempLocalFile =
                                    File(remedioFotoList[index].nome);
                                if (tempLocalFile.existsSync()) {
                                  // delete file
                                  tempLocalFile.delete(
                                    recursive: true,
                                  );
                                }

                                 Navigator.of(context).canPop();
                              },
                            );
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormFotoRemedioScreen(
                id: idRemedio,
                pet: pet,
              ),
            ),
          );
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
