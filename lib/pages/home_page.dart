import 'package:flutter/material.dart';

import 'items_choice_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const MyHomePage(),
      settings: const RouteSettings(name: '/homePage'),
    );
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'List Mix',
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                    color: Colors.white,
                    fontSize: 24,
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
                          color: Theme.of(context).primaryColor,
                      ),
                    )
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                Navigator.of(context).push(ItemsChoicePage.route());
              },
              tooltip: 'Go to items choice page',
              child: const Icon(Icons.arrow_right),
            ),
          ),
        ],
      ),
    );
  }
}