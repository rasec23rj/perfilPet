import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/screens/home/foto_bloc.dart';
import 'package:lifepet_app/screens/pet/perfil_pet_screen.dart';
Widget petCard(BuildContext context, int index, Pet pet) {

  FotoBloc blocFoto = FotoBloc();
  blocFoto.foto(pet);
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PerfilPetScreen(
            id: pet.id_pet,
          ),
        ),
      );
    },
    child: Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: pet.id_pet,
            child: Container(
              width: double.infinity,
              height: 250,
             child: StreamBuilder(

               stream: blocFoto.output,
               builder: (context, snapshot) {
                 return  Container(

                   child: blocFoto.nomefoto,
                 );
               }
             ),

            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12, 12, 40, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  pet.nome,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12, 12, 40, 0),
            child: Text(
              pet.descricao,
              style: TextStyle(
                  fontFamily: 'Montserrat', fontSize: 16, color: Colors.grey),
            ),
          )
        ],
      ),
    ),
  );
  // return Card(
  //   shadowColor: Colors.black,
  //   elevation: 10.0,
  //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  //   child: ListTile(
  //     isThreeLine: true,
  //     title: Text(
  //       pets.nome,
  //     ),
  //     subtitle: Text(pets.bio),
  //     leading: pets.imageURL == null
  //         ? Image.asset('assets/images/pet.png')
  //         : Image.file(
  //             File(pets.imageURL),
  //           ),
  //     trailing: GestureDetector(
  //       child: Icon(
  //         Icons.delete,
  //         color: Colors.redAccent,
  //       ),
  //       onTap: () {
  //         print("delete: ${pets.id_pet}");
  //       },
  //     ),
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => PerfilPetScreen(
  //             id: pets.id_pet,
  //           ),
  //         ),
  //       );
  //     },
  //   ),
  // );


}

