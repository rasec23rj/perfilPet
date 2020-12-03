import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/screens/remedio/remedio_screen.dart';
import 'package:lifepet_app/screens/vacinas/vacinas_screen.dart';

class MedicacaoScreen extends StatefulWidget {
  Pet pet;

  MedicacaoScreen({this.pet});
  @override
  _MedicacaoScreenState createState() => _MedicacaoScreenState();
}

class _MedicacaoScreenState extends State<MedicacaoScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Medicamentos do(a) ${widget.pet.nome}"),
      ),
      body: Card(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(
                Icons.healing,
                color: Colors.redAccent,
                size: 50.0,
              ),
              title: Text('Remédios'),
              subtitle: Text('Lista dos remédios'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RemedioScreen(id: widget.pet.id_pet)),
                );
              },
            ),
            Spacer(),
            ListTile(
              leading: Icon(
                Icons.local_hospital,
                color: Colors.redAccent,
                size: 50.0,
              ),
              title: Text('Vacinas'),
              subtitle: Text('Lista das Vacinas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          VacinasScreen(id: widget.pet.id_pet)),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.pets_rounded,
                color: Colors.redAccent,
                size: 50.0,
              ),
              title: Text('Vermifugo'),
              subtitle: Text('Lista dos Vermifugo'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RemedioScreen(id: widget.pet.id_pet)),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
