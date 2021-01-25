import 'package:de_resto/widgets/restaurant_card.dart';
import 'package:de_resto/constants/result_state.dart';
import 'package:de_resto/providers/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 60, bottom: 16),
              child: Text(
                "Favorite",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
              child: Consumer<DatabaseProvider>(
                builder: (context, provider, _) {
                  if (provider.state == ResultState.NoData) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 40,
                        ),
                        Text(
                          "Seems you dont add any favourite restaurant yet",
                          style: GoogleFonts.poppins(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ));
                  } else {
                    final restaurants = provider.favouriteRestaurants;
                    return ListView.builder(
                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        return RestaurantCard(restaurant: restaurants[index]);
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
