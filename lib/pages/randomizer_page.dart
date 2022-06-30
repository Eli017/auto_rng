import 'package:flutter/material.dart';
import '../widgets/duration_selector.dart';
import '../widgets/randomizer.dart';

class RandomizerPage extends StatefulWidget {
  const RandomizerPage({Key? key, required this.items}) : super(key: key);

  final List items;

  @override
  State<RandomizerPage> createState() => _RandomizerPageState();
}

class _RandomizerPageState extends State<RandomizerPage> {
  late bool isRandomizerActive = false;
  int millisecondDuration = 0;

  void toggleRandomizer(bool isActive) {
    setState(() => isRandomizerActive = isActive);
  }

  void updateDuration(int duration) {
    setState(() => millisecondDuration = duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your duration'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: !isRandomizerActive,
              maintainState: true,
              child: DurationSelector(updateDuration: updateDuration, toggleRandomizer: toggleRandomizer)
            ),
            Visibility(
                visible: isRandomizerActive,
                child: Randomizer(toggleRandomizer: toggleRandomizer, milliseconds: millisecondDuration, items: widget.items)
            ),
          ],
        ),
      ),
    );
  }
}
