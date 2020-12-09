import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/screens/pet/perfil_pet_screen.dart';
import 'package:lifepet_app/screens/medicacao/medicao.dart';

class CustomNavbar extends StatefulWidget {
  int paginaAberta;
  final Pet pet;
  CustomNavbar({this.pet, this.paginaAberta});

  @override
  _CustomNavbarState createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  Widget paginaAtual;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      // color: Colors.black,
      shape: CircularNotchedRectangle(),
      notchMargin: 10,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      widget.paginaAberta = 0;
                    });
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => PerfilPetScreen(id: widget.pet.id_pet),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.account_circle,
                        color:
                            widget.paginaAberta == 0 ? Colors.red : Colors.grey,
                      ),
                      Text(
                        "Perfil",
                        style: TextStyle(
                          color: widget.paginaAberta == 0
                              ? Colors.redAccent
                              : Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      widget.paginaAberta = 1;
                    });
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => MedicacaoScreen(pet: widget.pet),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.healing,
                        color:
                            widget.paginaAberta == 1 ? Colors.red : Colors.grey,
                      ),
                      Text(
                        "Medicações",
                        style: TextStyle(
                            color: widget.paginaAberta == 1
                                ? Colors.redAccent
                                : Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  // minWidth: 60,
                  padding: EdgeInsets.all(10),
                  onPressed: () {
                    setState(() {
                      widget.paginaAberta = 2;
                    });
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          //builder: (_) => ConsultaPetScreen(id: widget.pet.id,),
                          ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.local_hospital,
                        color:
                            widget.paginaAberta == 2 ? Colors.red : Colors.grey,
                      ),
                      Text(
                        "Consulta",
                        style: TextStyle(
                          color: widget.paginaAberta == 2
                              ? Colors.redAccent
                              : Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            MaterialButton(
              minWidth: 40,
              onPressed: () {
                setState(() {
                  widget.paginaAberta = 3;
                });
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.event_note,
                    color: widget.paginaAberta == 3 ? Colors.red : Colors.grey,
                  ),
                  Text(
                    "Anotações",
                    style: TextStyle(
                      color: widget.paginaAberta == 3
                          ? Colors.redAccent
                          : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
