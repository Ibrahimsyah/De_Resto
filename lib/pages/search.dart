import 'package:de_resto/widgets/restaurant_card.dart';
import 'package:de_resto/constants/colors.dart';
import 'package:de_resto/constants/result_state.dart';
import 'package:de_resto/data/restaurant_api.dart';
import 'package:de_resto/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ChangeNotifierProvider<SearchProvider>(
          create: (_) => SearchProvider(restaurantApi: RestaurantApi()),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Search",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Consumer<SearchProvider>(
                          builder: (context, state, _) {
                            return TextField(
                              autofocus: true,
                              onSubmitted: state.searchRestaurant,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32),
                                    borderSide: BorderSide(color: darkOrange),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32),
                                    borderSide:
                                        BorderSide(color: darkOrange, width: 2),
                                  ),
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                  hintText: 'Restaurant Name or Menu',
                                  hintStyle: TextStyle(fontSize: 16)),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Consumer<SearchProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.HasData) {
                      return ListView.builder(
                        itemCount: state.restaurants.length,
                        itemBuilder: (context, index) {
                          var restaurant = state.restaurants[index];
                          return RestaurantCard(restaurant: restaurant);
                        },
                      );
                    } else if (state.state == ResultState.Error) {
                      return Center(
                        child: Text(state.messages),
                      );
                    } else if (state.state == ResultState.NoData) {
                      return Center(
                        child: Text(state.messages),
                      );
                    } else if (state.state == ResultState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search, size: 80, color: darkGray),
                            Text("Search by inputting name or menu above")
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
