import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/screens/home/foto_bloc.dart';
import 'file:///C:/Users/jt/Desktop/Projetos/perfilPet-master/lib/screens/pet/components/form_pet_screen.dart';
import 'package:lifepet_app/services/pet_service.dart';
import 'package:lifepet_app/screens/home/components/pet_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PetService petService = PetService();
  List<Pet> pets = List();
  Future<List> _loadPets;

  @override
  void initState() {
    _loadPets = _getAllPets();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadPets,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          pets = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Life pet'),
            ),
            backgroundColor: Colors.white,
            body: ListView.builder(
              itemCount: pets.length,
              itemBuilder: (context, index) {
                return petCard(context, index, pets[index]);
              },
            ),
            floatingActionButton: new FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormPetScreen(id: -1),
                  ),
                );
              },
              label: Text("Cadastrar"),
              icon: Icon(Icons.pets),
              backgroundColor: Colors.redAccent,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<List> _getAllPets() async {
    return await petService.getAllPets();
  }
}
