import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class Randomizer extends StatefulWidget {
  final Function(bool) toggleRandomizer;

  const Randomizer({
    Key? key,
    required this.toggleRandomizer,
  }): super(key: key);

  @override
  State<Randomizer> createState() => _RandomizerState();
}

class _RandomizerState extends State<Randomizer> {
  int counter = 0;
  late Timer myTimer;
  int selectedNumber = 0;
  final Random rng = Random();

  void startTimer(int duration) {
    myTimer = Timer.periodic(Duration(seconds: duration), (timer) {
      final List numbers = [0, 1, 2, 3, 4, 5];
      setState(() => selectedNumber = numbers[rng.nextInt(numbers.length)]);
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
    startTimer(3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(selectedNumber.toString()),
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