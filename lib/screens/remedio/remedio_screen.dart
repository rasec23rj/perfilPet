import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/models/remedio_model.dart';
import 'file:///C:/Users/jt/Desktop/Projetos/perfilPet-master/lib/screens/remedio/components/form_remedio_pet_screen.dart';
import 'package:lifepet_app/services/pet_service.dart';
import 'package:lifepet_app/services/remedio_service.dart';
import 'package:lifepet_app/components/custom_navbar.dart';

class RemedioScreen extends StatefulWidget {
  int id;
  int cor = 0;

  var teste = TextDecoration.none;
  var textoButton = '"Concluir"';
  var iconButton = Icons.close;
  var corButton = 0;

  RemedioScreen(
      {this.id,
      this.cor,
      this.teste,
      this.textoButton,
      this.iconButton,
      this.corButton});

  @override
  _RemedioScreenState createState() => _RemedioScreenState();
}

class _RemedioScreenState extends State<RemedioScreen> {
  var texto = '0';
  final PetService petService = PetService();
  final RemedioService remedioService = RemedioService();
  List<Remedio> remedioList = [];
  Pet pet;
  Future<Pet> _loadPet;
  Future<Remedio> _loadRemedio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPet = _getPet(widget.id);
    _loadRemedio = _getRemedios(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadPet,
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            pet = asyncSnapshot.data;

            return Scaffold(
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Hero(
                          tag: pet.id_pet,
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
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: remedioList.length,
                          itemBuilder: (context, index) {
                            final item = remedioList[index];
                            return Card(
                              key: Key(item.id.toString()),
                              shadowColor: widget.cor == 0 || widget.cor == null
                                  ? Colors.black
                                  : Colors.green[900],
                              elevation: 10.0,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      // Expanded(
                                      //   flex: 2,
                                      //   child: ListTile(
                                      //     leading: Icon(Icons.healing,
                                      //         color: remedioList[index].id ==
                                      //                     index ||
                                      //                 widget.cor == null
                                      //             ? Colors.red
                                      //             : Colors.green[900]),
                                      //     title: Text(
                                      //       remedioList[index].nome,
                                      //       style: TextStyle(
                                      //           decoration: widget.teste,
                                      //           fontFamily: "Montserrat",
                                      //           fontSize: 14,
                                      //           fontWeight: FontWeight.bold,
                                      //           color: widget.cor == 0 ||
                                      //                   widget.cor == null
                                      //               ? Colors.red
                                      //               : Colors.green[900]),
                                      //     ),
                                      //     subtitle: Text(
                                      //       remedioList[index].data,
                                      //       style: TextStyle(
                                      //           decoration: widget.teste,
                                      //           fontFamily: "Montserrat",
                                      //           fontSize: 12,
                                      //           color: widget.cor == 0 ||
                                      //                   widget.cor == null
                                      //               ? Colors.red
                                      //               : Colors.green[900]),
                                      //       maxLines: 10,
                                      //     ),
                                      //   ),
                                      // ),
                                      // Expanded(
                                      //   flex: 1,
                                      //   child: FlatButton.icon(
                                      //     minWidth: 10,
                                      //     textColor: Colors.black,
                                      //     color: widget.corButton == 0 ||
                                      //             widget.corButton == null
                                      //         ? Colors.amber[200]
                                      //         : Colors.greenAccent[400],
                                      //     onPressed: () {
                                      //       setState(() {
                                      //         print("item ${index}");
                                      //         print("item ${index}");
                                      //
                                      //         if (remedioList[index]
                                      //                 .pet
                                      //                 .id_pet ==
                                      //             pet.id_pet) {
                                      //           // widget.corButton == 0 ||
                                      //           //    widget.corButton == null
                                      //           //    ? widget.corButton = 1
                                      //           //    : widget.corButton = 0;
                                      //           // widget.corButton == 0
                                      //           //     ? widget.cor = 0
                                      //           //     : widget.cor = 1;
                                      //           // widget.corButton == 0
                                      //           //     ? widget.teste =
                                      //           //     TextDecoration.lineThrough
                                      //           //     : widget.teste = TextDecoration.none;
                                      //           // widget.corButton == 0
                                      //           //     ? widget.textoButton = 'Concluido'
                                      //           //     : widget.textoButton = 'Concluir';
                                      //         }
                                      //       });
                                      //     },
                                      //     icon: Icon(
                                      //       widget.corButton == 1
                                      //           ? widget.iconButton =
                                      //               Icons.check_circle
                                      //           : widget.iconButton =
                                      //               Icons.close,
                                      //       size: 15,
                                      //     ),
                                      //     label: Text(widget.textoButton == null
                                      //         ? 'Concluir'
                                      //         : '${widget.textoButton}'),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormRemedioPetScreen(
                        id: pet.id_pet,
                      ),
                    ),
                  );
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.redAccent,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: CustomNavbar(
                pet: pet,
                paginaAberta: 1,
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<Pet> _getPet(int id) async {
    return await petService.getPet(id);
  }

  Future<Remedio> _getRemedios(int id) async {
   // return await remedioService.getRemedioPets(id);
  }
}