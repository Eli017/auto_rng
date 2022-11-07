import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  late Timer myTimer;
  late Timer countdownTimer;
  int currentDuration = 0;
  int currentCountdown = 0;
  String selectedItem = '';
  final Random rng = Random();
  final _channel = const MethodChannel('com.listMix.elisokeland');

  void startCountdownTimer() {
    countdownTimer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      if (currentCountdown == 0) {
        setState(() => currentCountdown = currentDuration);
      } else {
        setState(() => currentCountdown--);
      }
    });
  }

  void startTimer(int duration) {
    myTimer = Timer.periodic(Duration(milliseconds: duration), (timer) {
      setState(() => currentCountdown = duration);
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
    countdownTimer.cancel();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  void initState() {
    currentDuration = widget.milliseconds;
    currentCountdown = widget.milliseconds;
    startTimer(widget.milliseconds);
    startCountdownTimer();
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
        TextButton(
            child: const Text("Start LiveActivity"),
            onPressed: () async {
              try {
                await _channel.invokeMethod('startLiveActivity', {
                  'duration': currentDuration.toString()
                });
              } on PlatformException catch (e) {
                debugPrint("==== PlatformException '${e.message}' ====");
              }
            }),
        Text(
          Duration(milliseconds: currentCountdown).toString().substring(0, 11),
          style: themeData.textTheme.headline1?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
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