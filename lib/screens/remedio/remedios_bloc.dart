import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifepet_app/models/foto_remedio.dart';
import 'package:lifepet_app/services/foto_remedio_service.dart';
import 'package:lifepet_app/services/remedio_service.dart';

class RemedioBloc {
  RemedioService remedioService = RemedioService();
  FotoRemedio fotoRemedio;
  Future<List> loadFotoRemedio;
  List<FotoRemedio> remedioFotoList = List();
  FotoRemedioService fotoRemedioService = FotoRemedioService();
  File image;
  final picker = ImagePicker();
  final nomeControler = TextEditingController();
  PickedFile pickedFile;
  final StreamController<int> _streamController = StreamController();

  Sink<int> get input => _streamController.sink;

  Stream get output =>
      _streamController.stream.asyncMap((event) => getFotoRemedio(event));



  final StreamController _streamFoto = StreamController();

  Sink get inputFoto => _streamFoto.sink;

  Stream get outputFoto =>  _streamFoto.stream;



  Future<List> listaRemediosFotos(idRemedio) async {
    remedioService.getFotoRemedios(idRemedio).then((value) => remedioFotoList);
  }

  Future<FotoRemedio> getFotoRemedio(int id) async {
    return await fotoRemedioService.getFotoRemedioFist(id);
  }


  Future setImage(pickedFile)async{
    print('getImage.: ${pickedFile.path}');
    if (pickedFile != null) {
      image = File(pickedFile.path);
      nomeControler.text = pickedFile.path;
      inputFoto.add(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }
}
