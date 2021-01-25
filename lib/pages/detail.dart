import 'package:de_resto/widgets/menu_card.dart';
import 'package:de_resto/widgets/restaurant_review.dart';
import 'package:de_resto/constants/colors.dart';
import 'package:de_resto/constants/result_state.dart';
import 'package:de_resto/data/image_url.dart';
import 'package:de_resto/data/restaurant_api.dart';
import 'package:de_resto/providers/database_provider.dart';
import 'package:de_resto/providers/detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String restaurantId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: ChangeNotifierProvider<DetailProvider>(
        create: (_) => DetailProvider(
            restaurantApi: RestaurantApi(), restaurantId: restaurantId),
        child: Consumer<DetailProvider>(
          builder: (context, state, _) {
            var _restaurant = state.restaurantDetail;
            if (state.state == ResultState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.Error) {
              return Center(
                child: Text(state.messages),
              );
            } else if (state.state == ResultState.HasData) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Hero(
                          tag: _restaurant.restaurant.id,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(32),
                                bottomRight: Radius.circular(32)),
                            child: Image.network(
                              ImageUrl.large(_restaurant.restaurant.pictureId),
                              height: 300,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -20,
                          right: 20,
                          child: Consumer<DatabaseProvider>(
                            builder: (context, provider, child) {
                              return FutureBuilder(
                                future: provider.isFavorite(restaurantId),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final isFavorite = snapshot.data;
                                    return FloatingActionButton(
                                      backgroundColor: darkOrange,
                                      child: Icon(isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_outline),
                                      onPressed: () {
                                        if (isFavorite) {
                                          provider.deleteFavorite(restaurantId);
                                        } else {
                                          provider.addFavorite(
                                              _restaurant.restaurant);
                                        }
                                      },
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _restaurant.restaurant.name,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 4.0),
                                child: Icon(Icons.place_outlined,
                                    size: 14.0, color: darkGray),
                              ),
                              Text(
                                _restaurant.restaurant.city,
                                style: Theme.of(context).textTheme.headline4,
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              _restaurant.restaurant.description,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                          Text(
                            'Foods',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 16),
                            height: 30,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: _restaurant.menus.foods
                                  .map((food) => MenuCard(food))
                                  .toList(),
                            ),
                          ),
                          Text(
                            'Drinks',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            height: 30,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: _restaurant.menus.drinks
                                  .map((drink) => MenuCard(drink))
                                  .toList(),
                            ),
                          ),
                          RestaurantReview(reviews: _restaurant.customerReviews)
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(""),
              );
            }
          },
        ),
      ),
    );
  }
}
