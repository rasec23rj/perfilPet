import 'dart:math';

import 'package:lifepet_app/models/remedio_model.dart';
import 'package:lifepet_app/services/pet_service.dart';
import 'package:lifepet_app/utils/db_utils.dart';

class RemedioService {
  List<Remedio> _remedioList = [];
  final PetService petService = PetService();


  Future<List> getRemedioPets(int id) async {
    final dataUtils =  await DbUtil.getData("remedios");
    //_remedioList = dataUtils.map((e) => Remedio).toString();
   // return
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
