import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifepet_app/screens/remedio/components/form_foto_remedio.dart';
import 'package:lifepet_app/screens/remedio/remedio_controller.dart';
import 'package:lifepet_app/services/remedio_service.dart';
import 'package:provider/provider.dart';

Widget slideShow(context, remedioFotoList, index, remedio, idRemedio, pet) {
  RemedioService remedioService = RemedioService();
  RemedioController remedioController = Provider.of<RemedioController>(context);
  if (remedioController.remedioFotoList.length != 0) {
    remedioFotoList = remedioController.remedioFotoList;
  } else {
    remedioFotoList = remedioFotoList;
  }
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
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                              height: MediaQuery.of(context).size.height / 1.2,
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
                                      ? Image.asset('assets/images/pet.png')
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
                                    color:
                                        RemedioController.current == indexSlide
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
                  ),
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
