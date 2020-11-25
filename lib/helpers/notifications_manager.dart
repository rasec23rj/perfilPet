import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:notification_permissions/notification_permissions.dart';

class NotificationManager {
  NotificationManager._internal();

  static final NotificationManager _shared = NotificationManager._internal();
  static final List<String> notificationsmanages = [
    'Test1...',
    'Test2...',
    'Test3...'
  ];

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  factory NotificationManager() {
    return _shared;
  }

  FlutterLocalNotificationsPlugin initialuzeNotificatios() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings( );
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin
        .initialize(initializationSettings)
        .then((value) => _agendaNotificationTeste(0, 0, '', '', ''));

    return _flutterLocalNotificationsPlugin;
  }

  FlutterLocalNotificationsPlugin getCurrentNotificationPlugin() {
    return _flutterLocalNotificationsPlugin;
  }

  void cancelNotificationWith(int id) {
    _flutterLocalNotificationsPlugin.cancel(id);
  }

  void sheduleDailyNotifications(
      int hora, int minute, String dataRemedio, String nome, String pet) {
    _showDailyAtTime(hora, minute, dataRemedio, nome, pet);
  }

  void showNotifications() {
    _showNotification();
  }

  void showNotificationsAgenda(
      int hora, int minute, String dataRemedio, String nome, String pet) {
    _agendaNotification(hora, minute, dataRemedio, nome, pet);
  }

  void showNotificationsAgendaTeste(
      int hora, int minute, String dataRemedio, String nome, String pet) {
    _agendaNotificationTeste(hora, minute, dataRemedio, nome, pet);
  }

  Future<bool> getCheckNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus()
        .then((status) {
      switch (status) {
        case PermissionStatus.denied:
          return false;
        case PermissionStatus.granted:
          return true;
        case PermissionStatus.unknown:
          return false;
        default:
          return null;
      }
    });
  }

  Future<void> _showDailyAtTime(
      int hora, int minute, String dataRemedio, String nome, String pet) async {
    var time = Time(hora, minute, 0);
    if (hora != 0 && minute != 0 && dataRemedio != '' && pet != '') {
      print(
          "_agendaNotificationTeste: ${hora}:${minute}  ${dataRemedio}  ${nome}  ${pet}");
      var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
          "repeatDailyAtTime channel test123",
          "repeatDailyAtTime channel test123",
          "repeatDailyAtTime description");
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifs = NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      await _flutterLocalNotificationsPlugin.showDailyAtTime(
          999,
          'Remédio: ${nome}\r\n Dia: ${dataRemedio} \r\n horario: ${hora}:${minute}',
          'pet: ${pet}',
          time,
          platformChannelSpecifs);
    }
  }

  Future<void> _showNotification() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        "flutter_notif ", "flutter_notif", "show Notification",
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifs = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
        0, 'plaint title', 'plain body', platformChannelSpecifs,
        payload: 'item x');
  }

  Future<void> _agendaNotification(
      int hora, int minute, String dataRemedio, String nome, String pet) async {
    var time = Time(17, 45, 0);
    print("time: ${time.hour}:${time.minute}:${time.second}");
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'show weekly channel id',
        'show weekly channel name',
        'show weekly description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        0,
        'Remedio ${nome} pet ${pet}',
        'Weekly notification shown on Monday at approximately ${time.hour}:${time.minute}:${time.second}',
        Day.Monday,
        time,
        platformChannelSpecifics);
  }

  Future<void> _agendaNotificationTeste(
      int hora, int minute, String dataRemedio, String nome, String pet) async {
    if (hora != 0 && minute != 0 && dataRemedio != '' && pet != '') {
      print(
          "_agendaNotificationTeste: ${hora}:${minute}  ${dataRemedio}  ${nome}  ${pet}");

      var scheduledNotificationDateTime =
          DateTime.now().add(Duration(seconds: 5));
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'your other channel id',
          'your other channel name',
          'your other channel description');
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      NotificationDetails platformChannelSpecifics = NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      await _flutterLocalNotificationsPlugin.schedule(
          0,
          'Remédio: ${nome} Dia:  ${dataRemedio} horario: ${hora}:${minute}',
          'Nome do Pet: ${pet}',
          scheduledNotificationDateTime,
          platformChannelSpecifics,
          payload: 'item x',
          androidAllowWhileIdle: true);
    }
  }

  String _getNotificationManager() {
    return notificationsmanages[Random().nextInt(notificationsmanages.length)];
  }
}
