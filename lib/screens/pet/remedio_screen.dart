import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/widget/custom_navbar.dart';

class RemedioScreen extends StatefulWidget {
  final Pet pet;
  int cor = 0;
  var teste = TextDecoration.none;
  var textoButton = '"Concluir"';
  var iconButton = Icons.close;
  var corButton = 0;

  RemedioScreen(
      {this.pet,
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
              child: ListView(
                children: <Widget>[
                  Card(
                    shadowColor: widget.cor == 0 || widget.cor == null
                        ? Colors.red
                        : Colors.green[300],
                    elevation: 8.0,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.healing,
                              color: widget.cor == 0 || widget.cor == null
                                  ? Colors.red
                                  : Colors.green[300]),
                          title: Text(
                            'Remédios',
                            style: TextStyle(
                                decoration: widget.teste,
                                fontFamily: "Montserrat",
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: widget.cor == 0 || widget.cor == null
                                    ? Colors.red
                                    : Colors.green[300]),
                          ),
                          subtitle: Text(
                            'Bromoprida, Dia 10 as 18:00hs',
                            style: TextStyle(
                                decoration: widget.teste,
                                fontFamily: "Montserrat",
                                fontSize: 12,
                                color: widget.cor == 0 || widget.cor == null
                                    ? Colors.red
                                    : Colors.green[300]),
                            maxLines: 10,
                          ),
                        ),
                        FlatButton.icon(
                          textColor: Colors.black,
                          color:
                              widget.corButton == 0 || widget.corButton == null
                                  ? Colors.amber[200]
                                  : Colors.greenAccent[200],
                          onPressed: () {
                            setState(() {
                              widget.cor = 1;
                              widget.teste = TextDecoration.lineThrough;
                              widget.textoButton = 'Concluido';
                              widget.iconButton = Icons.check_circle;
                              widget.corButton = 1;
                              print(widget.corButton);
                            });
                          },
                          icon: Icon(
                              widget.iconButton == null
                                  ? Icons.close
                                  : Icons.cancel,
                              size: 18),
                          label: Text(widget.textoButton == null
                              ? 'Concluir'
                              : '${widget.textoButton}'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
