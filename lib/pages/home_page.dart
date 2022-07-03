import 'package:auto_rng/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'items_choice_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.setTheme}) : super(key: key);

  final Function setTheme;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: themeData.primaryColor,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Text(
                  'List Mix',
                  style: themeData.textTheme.headline1?.copyWith(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(ItemsChoicePage.route());
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: Text('Let\'s get started!',
                      style: TextStyle(
                        color: themeData.primaryColor,
                      ),
                    )
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                          SettingsPage(setTheme: setTheme)
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: Text('Settings',
                      style: TextStyle(
                        color: themeData.primaryColor,
                      ),
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}