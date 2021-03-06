import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class Randomizer extends StatefulWidget {
  final Function(bool) toggleRandomizer;
  final int milliseconds;
  final List items;

  const Randomizer({
    Key? key,
    required this.toggleRandomizer,
    required this.milliseconds,
    required this.items
  }): super(key: key);

  @override
  State<Randomizer> createState() => _RandomizerState();
}

class _RandomizerState extends State<Randomizer> {
  int counter = 0;
  late Timer myTimer;
  String selectedItem = '';
  final Random rng = Random();

  void startTimer(int duration) {
    myTimer = Timer.periodic(Duration(milliseconds: duration), (timer) {
      var newItem = widget.items[rng.nextInt(widget.items.length)];
      if (newItem is String) {
        setState(() => selectedItem = newItem);
      } else {
        setState(() => selectedItem = newItem.toString());
      }
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
  void initState() {
    startTimer(widget.milliseconds);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Column(
      children: [
        Text(
          selectedItem,
          style: themeData.textTheme.headline1?.copyWith(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: themeData.primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
              onPressed: () {
                widget.toggleRandomizer(false);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(100, 100),
                shape: const CircleBorder(),
              ),
              child: const Text('Stop')
          ),
        ),
      ],
    );
  }
}