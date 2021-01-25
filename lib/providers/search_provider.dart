import 'package:de_resto/constants/result_state.dart';
import 'package:de_resto/data/restaurant_api.dart';
import 'package:de_resto/data/models/restaurant.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  RestaurantApi restaurantApi;

  SearchProvider({this.restaurantApi});

  List<Restaurant> _restaurants;
  ResultState _state;
  String _messages;

  List<Restaurant> get restaurants => _restaurants;
  ResultState get state => _state;
  String get messages => _messages;

  Future searchRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      var results = await restaurantApi.getSearchRestaurantResult(query);
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
