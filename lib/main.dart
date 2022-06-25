import 'package:auto_rng/pages/items_choice_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Mix',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

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
            child: Text(
              'List Mix',
              style: Theme.of(context).textTheme.headline1?.copyWith(
                color: Colors.grey,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ItemsChoicePage(counter: 10,)));
              },
              tooltip: 'Go to items choice page',
              child: const Icon(Icons.arrow_right),
            ),
          )
        ],
      ),
    );
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       Navigator.push(context, MaterialPageRoute(builder: (context) => const ItemsChoicePage(counter: 10,)));
    //     },
    //     tooltip: 'Go to items choice page',
    //     child: const Icon(Icons.arrow_right),
    //   ),
    // );
  }
}
