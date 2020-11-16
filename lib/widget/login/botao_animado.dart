import 'package:flutter/material.dart';

class BotaoAnimado extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> diminuirBotao;

  BotaoAnimado({this.controller})
      : diminuirBotao =
  Tween(begin: 320.0, end: 45.0)
      .animate(
      new CurvedAnimation(
          curve: Interval(0.0, 0.150), parent: controller)
  );

  Widget _contruirAnimacao(BuildContext context, Widget child) {
    return InkWell(
      onTap: () {
        controller.forward();
      },
      child: Container(
        height: 45,
        width: diminuirBotao.value,
        decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Center(
          child: _conteudo(context),
        ),
      ),
    );
  }

  Widget _conteudo(BuildContext context) {
    if (diminuirBotao.value > 55) {
      return Text("Login".toLowerCase(),
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ));
    }else {
      return  CircularProgressIndicator(
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
