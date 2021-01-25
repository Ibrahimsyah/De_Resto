import 'package:de_resto/data/models/customer_review.dart';
import 'package:de_resto/data/models/restaurant.dart';

import './menus.dart';

class RestaurantDetail {
  Restaurant restaurant;
  Menus menus;
  List<CustomerReview> customerReviews;

  RestaurantDetail({this.restaurant, this.menus});

  RestaurantDetail.fromJson(Map<String, dynamic> json) {
    restaurant = Restaurant.fromJson(json);
    menus = Menus.fromJson(json['menus']);
    List<dynamic> reviews = json['customerReviews'];
    customerReviews =
        List.from(reviews.map((review) => CustomerReview.fromJson(review)));
  }
}
