import 'package:de_resto/constants/colors.dart';
import 'package:de_resto/data/models/customer_review.dart';
import 'package:flutter/material.dart';

class RestaurantReview extends StatelessWidget {
  final List<CustomerReview> reviews;

  RestaurantReview({@required this.reviews});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Restaurant Reviews",
            style: Theme.of(context).textTheme.headline3,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              var review = reviews[index];
              return Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: darkGray,
                      size: 60,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            review.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            review.review,
                            maxLines: 3,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
