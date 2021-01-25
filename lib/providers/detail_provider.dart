import 'package:de_resto/constants/result_state.dart';
import 'package:de_resto/data/restaurant_api.dart';
import 'package:de_resto/data/models/restaurant_detail.dart';
import 'package:flutter/material.dart';

class DetailProvider extends ChangeNotifier {
  RestaurantApi restaurantApi;
  String restaurantId;
  DetailProvider({@required this.restaurantApi, @required this.restaurantId}) {
    _getRestaurantInformation(this.restaurantId);
  }

  RestaurantDetail _restaurantDetail;
  bool favorite;
  ResultState _state;
  String _messages;

  RestaurantDetail get restaurantDetail => _restaurantDetail;
  ResultState get state => _state;
  String get messages => _messages;
  bool get isFavorite => favorite;

  Future _getRestaurantInformation(String restaurantId) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final result = await restaurantApi.getRestaurantDetail(restaurantId);
      if (result != null) {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantDetail = result;
      } else {
        _state = ResultState.NoData;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _messages = e;
    }
  }
}
