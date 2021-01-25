import 'package:de_resto/pages/detail.dart';
import 'package:de_resto/pages/favorite.dart';
import 'package:de_resto/pages/home.dart';
import 'package:de_resto/pages/search.dart';
import 'package:de_resto/pages/setting.dart';
import 'package:de_resto/pages/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static final homePage = '/';
  static final splashScreen = '/splash';
  static final detailScreen = '/detail';
  static final searchScreen = '/search';
  static final favoriteScreen = '/favorite';
  static final settingScreen = '/setting';

  static final routes = <String, WidgetBuilder>{
    homePage: (BuildContext context) => HomePage(),
    splashScreen: (BuildContext context) => SplashScreen(),
    detailScreen: (BuildContext context) => DetailScreen(),
    searchScreen: (BuildContext context) => SearchScreen(),
    favoriteScreen: (BuildContext context) => FavoriteScreen(),
    settingScreen: (BuildContext context) => SettingScreen()
  };
}
