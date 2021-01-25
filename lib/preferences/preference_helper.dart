import 'package:de_resto/constants/preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  final Future<SharedPreferences> preferences;
  static const REMINDER_DEFAULT_VALUE = false;
  PreferenceHelper({@required this.preferences});

  Future<bool> get notificationReminder async {
    final prefs = await preferences;
    return prefs.getBool(NOTIFICATION_REMINDER) ?? REMINDER_DEFAULT_VALUE;
  }

  void setNotificationReminder(bool value) async {
    final prefs = await preferences;
    prefs.setBool(NOTIFICATION_REMINDER, value);
  }
}
