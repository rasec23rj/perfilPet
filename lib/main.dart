import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lifepet_app/screens/login/login_screen.dart';
import 'package:lifepet_app/screens/remedio/remedio_controller.dart';
import 'package:provider/provider.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RemedioController>.value(value: RemedioController(),),
      ],
      child: MaterialApp(
        home: LoginScreen(),
        theme: ThemeData(
            primaryColor: Colors.redAccent, backgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
