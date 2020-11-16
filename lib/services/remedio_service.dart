import 'dart:math';

import 'package:lifepet_app/models/remedio_model.dart';
import 'package:lifepet_app/services/pet_service.dart';

class RemedioService {
  final List<Remedio> _remedioList = [];
  final PetService petService = PetService();
  static final RemedioService _singleton = RemedioService._internal();

  factory RemedioService() {
    return _singleton;
  }

  RemedioService._internal() {
    _remedioList.add(Remedio(
        nome: "Remédio X",
        data: "10/10/2020",
        id: 1,
        pet: petService.getPet(1)));
    _remedioList.add(Remedio(
        nome: "Remédio X",
        data: "10/10/2020",
        id: 2,
        pet: petService.getPet(1)));
    _remedioList.add(Remedio(
        nome: "Remédio X",
        data: "10/10/2020",
        id: 3,
        pet: petService.getPet(1)));
  }

  List getRemedioPets(int id) {
    return _remedioList.where((remedio) => remedio.pet.id_pet == id).toList();
  }

  void addRemedio(Remedio remedio) {
    return _remedioList.add(Remedio(
      nome: remedio.nome,
      data: remedio.data,
      id: Random().nextInt(100),
      pet: remedio.pet
    ));
  }
}
