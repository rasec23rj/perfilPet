import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:lifepet_app/models/pet_model.dart';

class FotoBloc {
  Image nomefoto ;

  final StreamController _streamController = StreamController();
  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  void foto(pet) {
      nomefoto =  pet.imageURL.contains('storage') == null
        ? Image.asset('assets/images/pet.png')
        : Image.file(
      File(pet.imageURL),
      height: double.infinity,
      width: double.infinity,
      filterQuality: FilterQuality.medium,
      fit: BoxFit.contain,
    );
      print("nomefoto: ${nomefoto}");
      input.add(nomefoto);
  }

}