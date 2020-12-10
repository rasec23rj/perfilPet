import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifepet_app/models/foto_remedio.dart';
import 'package:lifepet_app/models/remedio_model.dart';
import 'package:lifepet_app/screens/remedio/components/detalhe_remedio.dart';
import 'package:lifepet_app/screens/remedio/components/slideShow.dart';
import 'package:lifepet_app/services/remedio_service.dart';

String updatedDt;

Widget remedioCard(context, _loadRemedio, pet) {
  List<Remedio> remedioList = List();
  final RemedioService remedioService = RemedioService();
  Future<List> _loadFotoRemedio;
  List<FotoRemedio> remedioFotoList = List();

  return Center(
    child: Column(
      children: <Widget>[
        FutureBuilder(
            future: _loadRemedio,
            builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
              if (asyncSnapshot.hasData) {
                remedioList = asyncSnapshot.data;

                return Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: remedioList.length,
                      itemBuilder: (context, index) {
                        final item = remedioList[index];
                        selectedDate(
                            remedioList[index].inicioData,
                            remedioList[index].fimData,
                            remedioList[index].hora,
                            remedioList[index].descricao);

                        remedioService.sheduleDailyNotifications(
                            remedioList[index].hora,
                            remedioList[index].inicioData,
                            remedioList[index].nome,
                            pet.nome);

                        return Card(
                          key: Key(item.id.toString()),
                          shadowColor: Colors.grey,
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: ListTile(
                                      leading: Ink(
                                        decoration: const ShapeDecoration(
                                          color: Colors.white,
                                          shape: CircleBorder(),
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.healing,
                                            color: Colors.red,
                                          ),
                                          iconSize: 35,
                                          onPressed: () {
                                            _showFoto(
                                                _loadFotoRemedio,
                                                context,
                                                remedioList[index].id,
                                                index,
                                                remedioList[index].nome,
                                                remedioService,
                                                remedioList[index],
                                                pet,
                                                remedioFotoList);
                                          },
                                        ),
                                      ),
                                      title: Text(
                                        remedioList[index].nome,
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${updatedDt}",
                                        style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 12,
                                            color: Colors.red),
                                        maxLines: 10,
                                      ),
                                      trailing: Ink(
                                        decoration: const ShapeDecoration(
                                          color: Colors.white,
                                          shape: CircleBorder(),
                                        ),
                                        child: IconButton(
                                          icon: Icon(Icons.more_vert),
                                          iconSize: 30,
                                          onPressed: () {},
                                        ),
                                      ),
                                      isThreeLine: true,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetalheRemedioScreen(
                                                      id: remedioList[index].id,
                                                      pet: pet)),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                );
              } else if (asyncSnapshot.hasError) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.redAccent,
                  ),
                );
              } else {
                return Center(
                  child: Text("Este pet não possui remédios"),
                );
              }
            }),
      ],
    ),
  );
}

Future<void> _showFoto(_loadFotoRemedio, context, id, index, nome,
    remedioService, remedioList, pet, remedioFotoList) async {
  _loadFotoRemedio = remedioService.getFotoRemedios(id);

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return FutureBuilder(
        future: _loadFotoRemedio,
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            remedioFotoList = asyncSnapshot.data;
            print("_showFotoCard: ${remedioFotoList}");
            return Container(
              padding: EdgeInsets.all(1),
              //context, remedioFotoList, index, remedio, idRemedio, pet

              child: slideShow(context, remedioFotoList, index, nome, id, pet),
            );
          } else {
            return Container(
              padding: EdgeInsets.all(1),
              child: slideShow(context, remedioFotoList, index, nome, id, pet),
            );
          }
        },
      );
    },
  );
}

Future<void> selectedDate(
    String dateRem, String dataFim, String horaRem, String descricao) async {
  DateTime parseDt = DateTime.parse(dateRem);
  DateTime parseDtFinal = DateTime.parse(dataFim);
  var newFormat = DateFormat("dd/MM/yyyy");

  if (dateRem != null) {
    updatedDt =
        "Data inicio: ${newFormat.format(parseDt)}\n\tData fim: ${newFormat.format(parseDtFinal)}\n\tHorario: ${horaRem}\n\tDescrição: ${descricao} ";
  }
}
