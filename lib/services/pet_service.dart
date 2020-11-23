import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/utils/db_utils.dart';

class PetService {
  List<Pet> _petList = [];

  Future<List> getAllPets() async {
    final dataList = await DbUtil.getData('pets');
    _petList = dataList.map((pets) => Pet.fromMap(pets)).toList();
    return _petList;
  }

  void addPet(Pet pet) {
    print("addPet: ${pet.toMap()}");
    DbUtil.insertData('pets', pet.toMap());
  }

  Future<Pet> updatePet(int id, Pet pet) async {
    String whereString = "id_pet = ?";
    List<dynamic> whereArgumento = [id];
    print("updatePet: ${pet}");
    DbUtil.updteData("pets", pet.toMap(), whereString, whereArgumento);
  }

  Future<Pet> getPet(int id) async {
    List<String> colunas = [
      "id_pet",
      "nome",
      "idade",
      "imageURL",
      "descricao",
      "sexo",
      "cor",
      "bio"
    ];
    String whereString = "id_pet = ?";
    List<dynamic> whereArgumento = [id];
    final dataList =
        await DbUtil.getDataWhere("pets", colunas, whereString, whereArgumento);
    return Pet.fromMap(dataList.first);
  }
}
