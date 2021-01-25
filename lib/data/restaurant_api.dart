import 'package:de_resto/constants/api.dart';
import 'package:de_resto/data/models/restaurant.dart';
import 'package:de_resto/data/models/restaurant_detail.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RestaurantApi {
  Future<List<Restaurant>> getAllRestaurant() async {
    if (!await DataConnectionChecker().hasConnection) {
      return Future.error("No Internet Connection");
    }
    var response = await http.get(ENDPOINT_ALL_RESTAURANT);
    Map<String, dynamic> json = jsonDecode(response.body);
    var restaurants = List.from(json['restaurants']);
    return List.from(
        restaurants.map((restaurant) => Restaurant.fromJson(restaurant)));
  }

  Future<RestaurantDetail> getRestaurantDetail(String restaurantId) async {
    if (!await DataConnectionChecker().hasConnection) {
      return Future.error("No Internet Connection");
    }
    var response = await http.get(restaurantDetailEndpoint(restaurantId));
    Map<String, dynamic> json = jsonDecode(response.body);
    var restaurant = json['restaurant'];
    return RestaurantDetail.fromJson(restaurant);
  }

  Future<List<Restaurant>> getSearchRestaurantResult(String query) async {
    if (!await DataConnectionChecker().hasConnection) {
      return Future.error("No Internet Connection");
    }
    var response = await http.get(searchRestaurantEndpoint(query));
    Map<String, dynamic> json = jsonDecode(response.body);
    var restaurants = List.from(json['restaurants']);
    return List.from(
        restaurants.map((restaurant) => Restaurant.fromJson(restaurant)));
  }
}
