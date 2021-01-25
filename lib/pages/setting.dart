import 'package:de_resto/constants/colors.dart';
import 'package:de_resto/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 60, bottom: 16),
              child: Text("Settings",
                  style: Theme.of(context).textTheme.headline1),
            ),
            Consumer<SettingProvider>(
              builder: (context, preferences, _) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      title: Text("Enable Notification"),
                      subtitle: Text(
                          "Send restaurant recomendation on 11PM every day"),
                      trailing: Switch.adaptive(
                        value: preferences.isNotificationActive,
                        activeColor: darkOrange,
                        onChanged: (active) {
                          final notificationStatus =
                              active ? "Activated" : "Deactivated";
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Notification $notificationStatus")));
                          preferences.setNotificationPreference(active);
                        },
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
