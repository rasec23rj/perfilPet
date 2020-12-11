import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:lifepet_app/models/foto_remedio.dart';
import 'package:lifepet_app/services/remedio_service.dart';

class RemedioController extends ChangeNotifier {
  int current = 0;
  int idFotoRemedio = 0;
  String nomeFotoRemedio = '';
  final RemedioService remedioService = RemedioService();
  Future<List> loadFotoRemedio;
  List<FotoRemedio> remedioFotoList = List();

  int carrosel(index) {
    current = index;
    notifyListeners();
    return current;
  }

  deleteFotoShowId(id, nome) {
    idFotoRemedio = id;
    nomeFotoRemedio = nome;
    notifyListeners();
    return {idFotoRemedio, nomeFotoRemedio};
  }

  reloadFotoRemedio(id) {
    loadFotoRemedio = remedioService.getFotoRemedios(id);
    loadFotoRemedio.then((value) => {
          remedioFotoList = value,
        });

    notifyListeners();
  }
}
