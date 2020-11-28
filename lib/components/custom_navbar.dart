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
      color: Colors.black,
      shape: CircularNotchedRectangle(),
      child: Container(
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            MaterialButton(
              padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
              onPressed: () {
                setState(() {
                  print(widget.paginaAberta);
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
                    Icons.pets,
                    color: widget.paginaAberta == 0 ? Colors.red : Colors.grey,
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
              padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.healing,
                    color: widget.paginaAberta == 1 ? Colors.red : Colors.grey,
                  ),
                  Text(
                    "Medicações",
                    style: TextStyle(
                      color: widget.paginaAberta == 1
                          ? Colors.redAccent
                          : Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            MaterialButton(
              padding: EdgeInsets.fromLTRB(50.0, 0, 20, 0),
              onPressed: () {
                setState(() {
                  widget.paginaAberta = 2;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    Icons.local_hospital,
                    color: widget.paginaAberta == 2 ? Colors.red : Colors.grey,
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
            MaterialButton(
              padding: EdgeInsets.fromLTRB(0.0, 0, 0, 0),
              onPressed: () {
                setState(() {
                  widget.paginaAberta = 3;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
