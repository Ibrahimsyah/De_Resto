import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:de_resto/data/restaurant_api.dart';
import 'package:de_resto/main.dart';
import 'package:de_resto/utils/NotificationHelper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService _service;
  static String _isolateName = 'isolate';
  static SendPort _uiSendPort;

  BackgroundService._createObject();

  factory BackgroundService() {
    if (_service == null) {
      _service = BackgroundService._createObject();
    }
    return _service;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var results = await RestaurantApi().getAllRestaurant();
    var position = (new Random()).nextInt(results.length);
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, results[position]);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    print('Execute some process');
  }
}
