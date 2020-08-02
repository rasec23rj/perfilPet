import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/screens/form_pet_screen.dart';
import 'package:lifepet_app/screens/pet/perfil_pet_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          return _petCard(context, index);
        },
      ),
      floatingActionButton: new FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormPetScreen(),
            ),
          );
        },
        label: Text("Cadastrar"),
        icon: Icon(Icons.pets),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  Widget _petCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PerfilPetScreen(
              pet: pets[index],
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: new Text('pets[0].id_pet'),
              child: Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    image: DecorationImage(
                        image: AssetImage(pets[index].imageURL),
                        fit: BoxFit.fitWidth)),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 40, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    pets[index].nome,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 40, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    pets[index].bio,
                    style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                        color: Colors.black87),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
