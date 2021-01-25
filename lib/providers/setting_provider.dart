import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:de_resto/preferences/preference_helper.dart';
import 'package:de_resto/utils/background_service.dart';
import 'package:de_resto/utils/datetime_helper.dart';
import 'package:flutter/material.dart';

class SettingProvider extends ChangeNotifier {
  final PreferenceHelper preferenceHelper;
  SettingProvider({@required this.preferenceHelper}) {
    _getNotificationPreference();
  }

  bool _isNotificationActive = false;

  bool get isNotificationActive => _isNotificationActive;

  void _getNotificationPreference() async {
    _isNotificationActive = await preferenceHelper.notificationReminder;
    notifyListeners();
  }

  Future<bool> setNotificationPreference(bool value) async {
    preferenceHelper.setNotificationReminder(value);
    _getNotificationPreference();
    if (value) {
      print("Activated");
      notifyListeners();
      return await AndroidAlarmManager.periodic(
          Duration(hours: 24), 1, BackgroundService.callback,
          startAt: DateTimeHelper.format(), exact: true, wakeup: true);
    } else {
      print("Deactivated");
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
