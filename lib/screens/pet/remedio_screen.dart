import 'package:flutter/material.dart';
import 'package:lifepet_app/models/pet_model.dart';
import 'package:lifepet_app/widget/custom_navbar.dart';

class RemedioScreen extends StatefulWidget {
  final Pet pet;
  int cor = 0;
  var teste = TextDecoration.none;
  RemedioScreen({this.pet, this.cor, this.teste});

  @override
  _RemedioScreenState createState() => _RemedioScreenState();
}

class _RemedioScreenState extends State<RemedioScreen> {
  var texto = '0';

  @override
  Widget build(BuildContext context) {
    print(widget.cor);
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
                          leading: Icon(Icons.healing),
                          title: Text(
                            'Remédios',
                            style: TextStyle(
                              decoration: widget.teste,
                              fontFamily: "Montserrat",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Bromoprida, Dia 10 as 18:00hs',
                            maxLines: 10,
                          ),
                        ),
                        FlatButton.icon(
                          textColor: Colors.black,
                          color: Colors.amber[200],
                          onPressed: () {
                            setState(() {
                              print(widget.cor);
                              widget.cor = 1;
                              widget.teste = TextDecoration.lineThrough;
                            });
                          },
                          icon: Icon(Icons.close, size: 18),
                          label: Text("Concluir"),
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
