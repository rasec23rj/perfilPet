import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/services/pet_service.dart';
import 'package:lifepet_app/widget/custom_navbar.dart';

class PerfilPetScreen extends StatelessWidget {
  final int id;
  Pet pet;
  PetService petService = PetService();
  PerfilPetScreen({this.id}){
    _getPet(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Hero(
                  tag: new Text('pet.id_pet'),
                  child: Container(
                    width: double.infinity,
                    height: 350,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(pet.imageURL),
                            fit: BoxFit.cover)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40, left: 10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.redAccent[700],
                  ),
                )
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
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 25),
              child: Text(
                pet.bio,
                style: TextStyle(
                    fontFamily: "Montserrat", fontSize: 16, height: 1.5),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            )
            //cartao fim
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.edit),
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      bottomNavigationBar: CustomNavbar(
        pet: pet,
        paginaAberta: 0,
      ),
    );
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

  void _getPet(id){
     pet = petService.getPet(id);
  }
}
