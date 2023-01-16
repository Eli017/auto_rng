import 'dart:math';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Randomizer extends StatefulWidget {
  final Function(bool) toggleRandomizer;
  final int milliseconds;
  final List items;

  const Randomizer(
      {Key? key,
      required this.toggleRandomizer,
      required this.milliseconds,
      required this.items})
      : super(key: key);

  @override
  State<Randomizer> createState() => _RandomizerState();
}

class _RandomizerState extends State<Randomizer> {
  int currentDuration = 0;
  int currentCountdown = 0;
  String selectedItem = '';
  final Random rng = Random();

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
  );

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.setPresetTime(mSec: widget.milliseconds);
    _stopWatchTimer.onStartTimer();
    _stopWatchTimer.rawTime.listen((value) {
      if (value == 0) {
        var newItem = widget.items[rng.nextInt(widget.items.length)];
        if (newItem is String) {
          setState(() => selectedItem = newItem);
        } else {
          setState(() => selectedItem = newItem.toString());
        }
        _stopWatchTimer.onResetTimer();
        _stopWatchTimer.onStartTimer();
      }
    });
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Column(
      children: [
        /// Stream current time and selected item values.
        StreamBuilder<int>(
          stream: _stopWatchTimer.rawTime,
          initialData: _stopWatchTimer.rawTime.value,
          builder: (context, snap) {
            final value = snap.data;
            return Column(
              children: <Widget>[
                Text(
                  selectedItem,
                  style: themeData.textTheme.headline1?.copyWith(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: themeData.primaryColor,
                  ),
                ),
                Text(
                  StopWatchTimer.getDisplayTime(value ?? 0),
                  style: themeData.textTheme.headline1?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
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
              child: const Text('Stop')),
        ),
      ],
    );
  }
}
