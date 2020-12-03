import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/models/vacinas.dart';
import 'package:lifepet_app/screens/remedio/components/detalhe_remedio.dart';
import 'package:lifepet_app/screens/vacinas/components/forms/form_vacinas_screen.dart';
import 'package:lifepet_app/services/pet_service.dart';
import 'package:lifepet_app/services/vacinas_service.dart';

class VacinasScreen extends StatefulWidget {
  Pet pet;
  int id;
  VacinasScreen({this.pet, this.id});

  @override
  _VacinasScreenState createState() => _VacinasScreenState();
}

class _VacinasScreenState extends State<VacinasScreen> {
  VacinasService vacinasService = VacinasService();
  PetService petService = PetService();
  Future<Pet> _loadPet;
  Future<List> _loadVacinas;
  List<Vacinas> vacinasList = [];
  String updatedDt;
  String nomePet;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadVacinas = listVacinas(widget.id);
    _loadPet = _getPet(widget.id);
    _loadPet.then((value) => {
          widget.pet = value,
          if (widget.pet != null) {setNome(value.nome)}
        });
    print("widget.pet: ${widget.pet}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Vacinas do(a): ${nomePet}"),
        ),
        body: FutureBuilder(
          future: _loadVacinas,
          builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              vacinasList = asyncSnapshot.data;
              return Cards();
            } else if (asyncSnapshot.hasError) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.redAccent,
                ),
              );
            } else {
              return Container(
                padding: EdgeInsets.all(15),
                child: Text("Este pet não possui vacinas"),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormVacinaScreen(
                  id: widget.id,
                ),
              ),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        ),
      ),
    );
  }

  Widget Cards() {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: vacinasList.length,
      itemBuilder: (context, index) {
        final itemVacina = vacinasList[index];
        if (vacinasList.length != 0) {
          return ListView(
            children: [
              ListTile(
                leading: Icon(Icons.ac_unit),
                title: Text(
                  "${itemVacina.nome}\r\t\n ",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${itemVacina.inicioData}\r\t\n" +
                      " ${itemVacina.fimData}\r\t\n" +
                      "${itemVacina.hora}\r\t\n",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 12,
                      color: Colors.red),
                  maxLines: 10,
                ),
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => DetalheRemedioScreen(
                //             id: remedioList[index].id, pet: widget.pet)),
                //   );
                // },
                //title: Text(itemVacina[index]),
              ),
            ],
          );
        }
      },
    );
  }

  Future<List> listVacinas(int id) async {
    return await vacinasService.getVacinasPets(id);
  }

  Future<Pet> _getPet(int id) async {
    return await petService.getPet(id);
  }

  Future<void> _selectedDate(String dateRem) async {
    String strDt = dateRem;
    DateTime parseDt = DateTime.parse(strDt);
    var newFormat = DateFormat("dd/MM/yyyy");

    if (dateRem != null) {
      updatedDt = newFormat.format(parseDt);
    }
  }

  void setNome(String nome) {
    setState(() {
      if (nome != null) {
        nomePet = nome;
      } else {
        print('No image selected.');
      }
    });
  }
}
