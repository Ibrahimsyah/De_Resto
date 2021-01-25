import 'package:de_resto/constants/colors.dart';
import 'package:de_resto/data/models/menus.dart';
import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final Menu menu;
  MenuCard(this.menu);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: darkOrange,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Center(
              child: Text(
                menu.name,
                style: TextStyle(color: white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
