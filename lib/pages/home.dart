import 'package:de_resto/widgets/restaurant_card.dart';
import 'package:de_resto/constants/colors.dart';
import 'package:de_resto/constants/result_state.dart';
import 'package:de_resto/providers/restaurant_provider.dart';
import 'package:de_resto/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _onSearchClick() {
      Navigator.pushNamed(context, AppRoutes.searchScreen);
    }

    void _onFavoriteClick() {
      Navigator.pushNamed(context, AppRoutes.favoriteScreen);
    }

    void _onSettingClick() {
      Navigator.pushNamed(context, AppRoutes.settingScreen);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: SpeedDial(
        child: Icon(Icons.menu),
        closedForegroundColor: Colors.white,
        openForegroundColor: darkOrange,
        closedBackgroundColor: darkOrange,
        openBackgroundColor: Colors.white,
        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
            backgroundColor: darkOrange,
            child: Icon(Icons.search),
            label: "Search Restaurant",
            onPressed: _onSearchClick,
          ),
          SpeedDialChild(
            backgroundColor: darkOrange,
            child: Icon(Icons.favorite),
            label: "Favorite Restaurant",
            onPressed: _onFavoriteClick,
          ),
          SpeedDialChild(
            backgroundColor: darkOrange,
            child: Icon(Icons.settings),
            label: "Setting",
            onPressed: _onSettingClick,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 60, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('De Resto',
                      style: Theme.of(context).textTheme.headline1),
                  Text('Find your Favorite Restaurant Here',
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ),
            Consumer<RestaurantProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.HasData) {
                  final restaurants = state.restaurants;
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      return RestaurantCard(restaurant: restaurants[index]);
                    },
                  );
                } else if (state.state == ResultState.NoData) {
                  return Center(
                    child: Text("No Data"),
                  );
                } else {
                  return Text("");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
