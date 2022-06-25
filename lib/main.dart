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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'List Mix'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _duration = 0;
  late Timer myTimer;

  void startTimer(int duration) {
    myTimer = Timer.periodic(Duration(seconds: duration), (timer) {
      setState(() {
        _counter++;
      });
    });
  }

  void stopTimer() {
    myTimer.cancel();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Input Duration Time:',
              style: TextStyle(
                height: 10,
              ),
            ),
            SizedBox(
              width: 100.0,
              child: TextField(
                onChanged: ((text) {
                  if (text.isNotEmpty) {
                    setState(() => _duration = int.parse(text));
                  }
                }),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(onPressed: (() {
              stopTimer();
              setState(() {
                _counter = 0;
              });
            }), child: const Text('Stop timer')),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ItemsChoicePage(counter: 10,)));
          // if (_duration == 0) {
          //   startTimer(1);
          // } else {
          //   myTimer.cancel();
          //   startTimer(_duration);
          // }
        },
        tooltip: 'Go to items choice page',
        child: const Icon(Icons.arrow_right),
      ),
    );
  }
}
