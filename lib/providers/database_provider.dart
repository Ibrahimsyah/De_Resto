import 'package:de_resto/constants/result_state.dart';
import 'package:de_resto/data/db_helper.dart';
import 'package:de_resto/data/models/restaurant.dart';
import 'package:flutter/material.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper helper;

  DatabaseProvider({@required this.helper}) {
    _getAllFavorites();
  }

  ResultState _state;
  String _messages;
  List<Restaurant> _favoriteRestaurants;

  ResultState get state => _state;
  String get messages => _messages;
  List<Restaurant> get favouriteRestaurants => _favoriteRestaurants;

  void _getAllFavorites() async {
    _favoriteRestaurants = await helper.getAllRestaurants();
    _state = _favoriteRestaurants.length > 0
        ? ResultState.HasData
        : ResultState.NoData;
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await helper.insertRestaurant(restaurant);
      _getAllFavorites();
    } catch (e) {
      _messages = e;
      _state = ResultState.Error;
      notifyListeners();
    }
  }

  void deleteFavorite(String restaurantId) async {
    try {
      await helper.deleteRestaurant(restaurantId);
      _getAllFavorites();
    } catch (e) {
      _messages = e;
      _state = ResultState.Error;
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String restaurantId) async {
    final restaurant = await helper.getRestaurantById(restaurantId);
    return restaurant != null;
  }
}
