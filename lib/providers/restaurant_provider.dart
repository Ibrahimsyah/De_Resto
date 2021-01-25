import 'package:de_resto/constants/result_state.dart';
import 'package:de_resto/data/restaurant_api.dart';
import 'package:de_resto/data/models/restaurant.dart';
import 'package:flutter/material.dart';

class RestaurantProvider extends ChangeNotifier {
  final RestaurantApi restaurantApi;

  RestaurantProvider({@required this.restaurantApi}) {
    _fetchAllRestaurants();
  }

  List<Restaurant> _restaurants;
  String _messages = "";
  ResultState _state;

  List<Restaurant> get restaurants => _restaurants;
  String get messages => _messages;
  ResultState get state => _state;

  Future _fetchAllRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final results = await restaurantApi.getAllRestaurant();
      if (results.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _messages = "No Data";
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurants = results;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _messages = e;
    }
  }
}
