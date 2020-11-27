import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/screens/pet/perfil_pet_screen.dart';

Widget petCard(BuildContext context, int index, Pet pets) {
  // return GestureDetector(
  //   onTap: () {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => PerfilPetScreen(
  //           id: pets.id_pet,
  //         ),
  //       ),
  //     );
  //   },
  //   child: Container(
  //     padding: EdgeInsets.all(10),
  //     child: Row(
  //       children: <Widget>[
  //         Expanded(
  //           flex: 1,
  //           child: Container(
  //             height: 80,
  //             width: 70,
  //             child: Center(
  //               child: pets.imageURL == null
  //                   ? Text('No image selected.')
  //                   : Image.file(File(pets.imageURL)),
  //             ),
  //           ),
  //         ),
  //         Container(
  //           width: 10,
  //         ),
  //         Expanded(
  //           flex: 4,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             textDirection: TextDirection.ltr,
  //             children: [
  //               Text(
  //                 pets.nome,
  //                 style: TextStyle(
  //                     fontFamily: 'PlayfairDisplay',
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.black),
  //               ),
  //               Text(
  //                 pets.bio,
  //                 style: TextStyle(
  //                     fontFamily: 'PlayfairDisplay',
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w100,
  //                     color: Colors.black87),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  // );

  return Card(
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
