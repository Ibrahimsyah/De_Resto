import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:de_resto/common/navigation.dart';
import 'package:de_resto/constants/app_themes.dart';
import 'package:de_resto/data/db_helper.dart';
import 'package:de_resto/data/restaurant_api.dart';
import 'package:de_resto/preferences/preference_helper.dart';
import 'package:de_resto/providers/database_provider.dart';
import 'package:de_resto/providers/restaurant_provider.dart';
import 'package:de_resto/providers/setting_provider.dart';
import 'package:de_resto/routes/routes.dart';
import 'package:de_resto/utils/NotificationHelper.dart';
import 'package:de_resto/utils/background_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(
            helper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(
            restaurantApi: RestaurantApi(),
          ),
        ),
        ChangeNotifierProvider<SettingProvider>(
          create: (_) => SettingProvider(
            preferenceHelper: PreferenceHelper(
              preferences: SharedPreferences.getInstance(),
            ),
          ),
        )
      ],
      child: MaterialApp(
        title: 'De Resto',
        theme: appTheme,
        navigatorKey: navigatorKey,
        initialRoute: AppRoutes.splashScreen,
        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
