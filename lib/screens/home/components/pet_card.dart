import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/screens/pet/perfil_pet_screen.dart';

Widget petCard(BuildContext context, int index, Pet pets) {

  return GestureDetector(
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

    // child: Padding(
    //   padding: EdgeInsets.only(bottom: 40),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       Hero(
    //         tag: new Text('pets[0].id_pet'),
    //         child: Container(
    //           width: double.infinity,
    //           height: 250,
    //           decoration: BoxDecoration(
    //               borderRadius: BorderRadius.all(Radius.circular(0)),
    //               image: DecorationImage(
    //                   image: AssetImage(pets.imageURL),
    //                   fit: BoxFit.fitWidth)),
    //         ),
    //       ),
    //       Padding(
    //         padding: EdgeInsets.fromLTRB(12, 12, 40, 0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //             Text(
    //               pets.nome,
    //               style: TextStyle(
    //                   fontFamily: 'Montserrat',
    //                   fontSize: 24,
    //                   fontWeight: FontWeight.bold,
    //                   color: Colors.black),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding: EdgeInsets.fromLTRB(12, 12, 40, 0),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //             Text(
    //               pets.bio,
    //               style: TextStyle(
    //                   fontFamily: 'PlayfairDisplay',
    //                   fontSize: 14,
    //                   fontWeight: FontWeight.w100,
    //                   color: Colors.black87),
    //             ),
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // ),
    child: Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              height: 80,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  image: DecorationImage(
                      image: AssetImage(pets.imageURL),
                      fit: BoxFit.fitWidth)),
            ),
          ),
          Container(
            width: 10,
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: [

                Text(
                  pets.nome,
                  style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  pets.bio,
                  style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 16,
                      fontWeight: FontWeight.w100,
                      color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}