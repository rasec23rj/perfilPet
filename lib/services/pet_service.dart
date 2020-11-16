import 'dart:math';

import 'package:lifepet_app/models/pet_model.dart';

class PetService {
  final List<Pet> _petList = [];

  static final PetService _singleton = PetService._internal();

  factory PetService(){
    return _singleton;
  }
  PetService._internal() {
    _petList.add(Pet(
        nome: 'Max',
        imageURL: 'assets/images/max.jpg',
        descricao: 'Um cachorro esperto',
        idade: 2,
        sexo: 'Macho',
        cor: 'Marrom e preto',
        bio: 'Sou um Max bem esperto',
        id_pet: 1));
    _petList.add(Pet(
        nome: 'Maria',
        imageURL: 'assets/images/maria.jpg',
        descricao: 'Um carinhosa',
        idade: 5,
        sexo: 'Femia',
        cor: 'Branca e bege',
        bio: 'Sou um Poodle bem carinhosa',
        id_pet: 2));
    _petList.add(Pet(
        nome: 'Darlene',
        imageURL: 'assets/images/lene.jpg',
        descricao: 'Um carinhosa',
        idade: 8,
        sexo: 'Femia',
        cor: 'Branca e bege',
        bio: 'Sou um Poodle bem carinhosa',
        id_pet: 3));
    _petList.add(Pet(
        nome: 'Clarice',
        imageURL: 'assets/images/clarice.jpg',
        descricao: 'Um carinhosa',
        idade: 1,
        sexo: 'Femia',
        cor: 'Branca ,bege e preto',
        bio: 'Sou um cadelinha bem carinhosa e brincanhona',
        id_pet: 4));
    _petList.add(Pet(
        nome: 'Preciosa',
        imageURL: 'assets/images/preci.jpg',
        descricao: 'Um carinhosa',
        idade: 8,
        sexo: 'Femia',
        cor: 'Branca ,bege ',
        bio: 'Sou um cadelinha bem carinhosa e brincanhona',
        id_pet: 5));
  }

  List getAllPets(){
    return _petList;
  }

  void addPet(Pet pet){
    _petList.add(Pet(
      nome: pet.nome,
      bio: pet.bio,
      idade: pet.idade,
      sexo: pet.sexo,
      descricao: pet.descricao,
      cor: pet.cor,
      id_pet: Random().nextInt(100),
      imageURL: 'assets/images/preci.jpg'
    ));
    print(_petList.length);
  }

  void updatePet(int id, Pet pet){
    Pet peteditar = getPet(id);
    peteditar.nome = pet.nome;
    peteditar.descricao = pet.descricao;
    peteditar.idade = pet.idade;
    peteditar.bio = pet.bio;
    peteditar.sexo = pet.sexo;
    peteditar.cor = pet.cor;
  }
  Pet getPet(int id){
    return _petList.singleWhere((pet) =>  pet.id_pet == id);
  }
}
