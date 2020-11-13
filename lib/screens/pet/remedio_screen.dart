import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/models/remedio_model.dart';
import 'package:lifepet_app/screens/pet/form_remedio_pet_screen.dart';
import 'package:lifepet_app/services/pet_service.dart';
import 'package:lifepet_app/services/remedio_service.dart';
import 'package:lifepet_app/widget/custom_navbar.dart';

class RemedioScreen extends StatefulWidget {
  final int id;
  int cor = 0;
  List<Remedio> remedioList = [];
  final PetService petService = PetService();
  final RemedioService remedioService = RemedioService();
  Pet pet;
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
      this.corButton}) {
    _getPet(this.id);
    _getRemedios(this.id);
  }

  @override
  _RemedioScreenState createState() => _RemedioScreenState();

  void _getPet(int id) {
    pet = petService.getPet(id);
  }

  void _getRemedios(int id) {
    remedioList = remedioService.getRemedioPets(id);
    print(remedioList[0].nome);
  }
}

class _RemedioScreenState extends State<RemedioScreen> {
  var texto = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Hero(
                  tag: widget.pet.id_pet,
                  child: Container(
                    width: double.infinity,
                    height: 350,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(widget.pet.imageURL),
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
                  itemCount: widget.remedioList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shadowColor: widget.cor == 0 || widget.cor == null
                          ? Colors.red
                          : Colors.green[900],
                      elevation: 8.0,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.healing,
                                color: widget.cor == 0 || widget.cor == null
                                    ? Colors.red
                                    : Colors.green[900]),
                            title: Text(
                              widget.remedioList[index].nome,
                              style: TextStyle(
                                  decoration: widget.teste,
                                  fontFamily: "Montserrat",
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: widget.cor == 0 || widget.cor == null
                                      ? Colors.red
                                      : Colors.green[900]),
                            ),
                            subtitle: Text(
                              widget.remedioList[index].data,
                              style: TextStyle(
                                  decoration: widget.teste,
                                  fontFamily: "Montserrat",
                                  fontSize: 12,
                                  color: widget.cor == 0 || widget.cor == null
                                      ? Colors.red
                                      : Colors.green[900]),
                              maxLines: 10,
                            ),
                          ),
                          FlatButton.icon(
                            textColor: Colors.black,
                            color: widget.corButton == 0 ||
                                    widget.corButton == null
                                ? Colors.amber[200]
                                : Colors.greenAccent[400],
                            onPressed: () {
                              setState(() {
                                widget.corButton == 0 || widget.corButton == null
                                    ? widget.corButton = 1
                                    : widget.corButton = 0;
                                widget.corButton == 0
                                    ? widget.cor = 0
                                    : widget.cor = 1;
                                widget.corButton == 0
                                    ? widget.teste = TextDecoration.lineThrough
                                    : widget.teste = TextDecoration.none;
                                widget.corButton == 0
                                    ? widget.textoButton = 'Concluido'
                                    : widget.textoButton = 'Concluir';
                              });

                            },
                            icon: Icon(
                              widget.corButton == 1
                                  ? widget.iconButton = Icons.check_circle
                                  : widget.iconButton = Icons.close,
                              size: 18,
                            ),
                            label: Text(widget.textoButton == null
                                ? 'Concluir'
                                : '${widget.textoButton}'),
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
                pet: widget.pet,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomNavbar(
        pet: widget.pet,
        paginaAberta: 1,
      ),
    );
  }
}
