import 'package:de_resto/constants/colors.dart';
import 'package:de_resto/data/image_url.dart';
import 'package:de_resto/data/models/restaurant.dart';
import 'package:de_resto/routes/routes.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final void Function(Restaurant restaurant) onRestaurantClick;

  RestaurantCard({this.restaurant, this.onRestaurantClick});

  @override
  Widget build(BuildContext context) {
    void _onRestaurantClick(Restaurant restaurant) {
      Navigator.pushNamed(context, AppRoutes.detailScreen,
          arguments: restaurant.id);
    }

    return Container(
        child: Column(
      children: [
        FlatButton(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          onPressed: () => _onRestaurantClick(restaurant),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Hero(
                        tag: restaurant.id,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Image.network(
                            ImageUrl.small(restaurant.pictureId),
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(restaurant.name,
                              style: Theme.of(context).textTheme.headline3),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 4.0),
                                child: Icon(Icons.place_outlined,
                                    size: 12.0, color: darkGray),
                              ),
                              Text(
                                restaurant.city,
                                style: Theme.of(context).textTheme.subtitle2,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 4.0),
                                child: Icon(Icons.star_outline,
                                    size: 12.0, color: darkGray),
                              ),
                              Text(
                                '${restaurant.rating}',
                                style: Theme.of(context).textTheme.subtitle2,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(
            thickness: 1,
            height: 5,
          ),
        )
      ],
    ));
  }
}
