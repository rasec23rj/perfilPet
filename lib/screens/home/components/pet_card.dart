import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/screens/pet/perfil_pet_screen.dart';

Widget petCard(BuildContext context, int index, Pet pets) {
  return Card(
    shadowColor: Colors.black,
    elevation: 10.0,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    child: ListTile(
      isThreeLine: true,
      title: Text(
        pets.nome,
      ),
      subtitle: Text(pets.bio),
      leading: pets.imageURL == null
          ? Image.asset('assets/images/pet.png')
          : Image.file(
              File(pets.imageURL),
            ),
      trailing: GestureDetector(
        child: Icon(
          Icons.delete,
          color: Colors.redAccent,
        ),
        onTap: () {
          print("delete: ${pets.id_pet}");
        },
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PerfilPetScreen(
              id: pets.id_pet,
            ),
          ),
        );
      },
    ),
  );
}
