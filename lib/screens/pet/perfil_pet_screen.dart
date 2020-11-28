import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'file:///C:/Users/jt/Desktop/Projetos/perfilPet-master/lib/screens/pet/components/form_pet_screen.dart';
import 'package:lifepet_app/services/pet_service.dart';
import 'package:lifepet_app/components/custom_navbar.dart';

class PerfilPetScreen extends StatefulWidget {
  int id;

  PerfilPetScreen({this.id});

  @override
  _PerfilPetScreenState createState() => _PerfilPetScreenState();
}

class _PerfilPetScreenState extends State<PerfilPetScreen> {
  Pet pet;
  PetService petService = PetService();
  Future<Pet> _loadPet;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadPet = _getPet(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadPet,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            pet = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text("Perfil do ${pet.nome}"),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Hero(
                          tag: new Text('pet.id_pet'),
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Container(
                              child: pet.imageURL == null
                                  ? Text('No image selected.')
                                  : Image.file(
                                      File(pet.imageURL),
                                      fit: BoxFit.fitWidth,
                                      alignment: Alignment.center,
                                      width: 500.0,
                                      height: 350.0,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    //Title
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            pet.nome,
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            pet.descricao,
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 16,
                                color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    //Title fim

                    //cartao
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 90,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          _cartaoInfoPet('Idade', pet.idade.toString()),
                          _cartaoInfoPet('Sexo', pet.sexo.toString()),
                          _cartaoInfoPet('Cor', pet.cor.toString())
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                      child: Text(
                        pet.bio,
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 16,
                            height: 1.5),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                    //cartao fim
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => FormPetScreen(id: pet.id_pet)));
                },
                child: Icon(Icons.edit),
                backgroundColor: Colors.redAccent,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniCenterDocked,
              floatingActionButtonAnimator:
                  FloatingActionButtonAnimator.scaling,
              bottomNavigationBar: CustomNavbar(
                pet: pet,
                paginaAberta: 0,
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _cartaoInfoPet(String label, String informacao) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 100,
      decoration: BoxDecoration(
        // color: Color(0xFFF8F2F7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.red),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            informacao,
            style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        ],
      ),
    );
  }

  Future<Pet> _getPet(int id) async {
    return await petService.getPet(id);
  }
}
