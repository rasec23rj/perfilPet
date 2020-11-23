import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class BotaoAnimado extends StatelessWidget {
  final AnimationController controller;
  Animation<double> diminuirBotao;
  Animation<double> aumentarBotao;

  BotaoAnimado({this.controller})
      : diminuirBotao = Tween(begin: 320.0, end: 45.0).animate(
            CurvedAnimation(curve: Interval(0.0, 0.150), parent: controller)),
        aumentarBotao = Tween(begin: 45.0, end: 1000.0).animate(CurvedAnimation(
            curve: Interval(0.5, 1, curve: Curves.bounceOut),
            parent: controller));

  Widget _contruirAnimacao(BuildContext context, Widget child) {
    return InkWell(
      onTap: () {
        controller.forward();
      },
      child: aumentarBotao.value <= 45
          ? Container(
              height: 45,
              width: diminuirBotao.value,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Center(
                child: _conteudo(context),
              ),
            )
          : Container(
              height: aumentarBotao.value,
              width: aumentarBotao.value,
              padding: EdgeInsets.only(top: 1),
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: aumentarBotao.value < 500
                      ? BoxShape.circle
                      : BoxShape.rectangle),
            ),
    );
  }

  Widget _conteudo(BuildContext context) {
    if (diminuirBotao.value > 55) {
      return Text("Login".toLowerCase(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
    } else {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 1.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _contruirAnimacao);
  }
}
