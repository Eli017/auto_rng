import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../helpers/time_conversion.dart';

class DurationSelector extends StatefulWidget {
  final Function(int) updateDuration;
  final Function(bool) toggleRandomizer;

  const DurationSelector({
    Key? key,
    required this.updateDuration,
    required this.toggleRandomizer,
  }) : super(key: key);

  @override
  State<DurationSelector> createState() => _DurationSelectorState();
}

class _DurationSelectorState extends State<DurationSelector>  {
  int minutes = 0;
  int seconds = 0;
  int milliseconds = 0;
  int currentDuration = 0;
  bool isEnabled = false;

  void updateCurrentDuration() {
    int minuteMilliseconds = convertMinutesToMilliseconds(minutes);
    int secondMilliseconds = convertSecondsToMilliseconds(seconds);
    int newMilliseconds = minuteMilliseconds + secondMilliseconds + milliseconds;
    print(newMilliseconds);
    setState(() => currentDuration = newMilliseconds);
    //Every frame within 60fps is approximately 16.3 milliseconds.
    //Therefore, this app must have a function delay of at least 17 seconds.
    if (currentDuration >= 17) {
      setState(() => isEnabled = true);
    } else {
      setState(() => isEnabled = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Flexible(
              flex: 1,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Minutes',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (text) {
                  int currentMinutes = text.isNotEmpty ? int.parse(text) : 0;
                  setState(() => minutes = currentMinutes);
                  updateCurrentDuration();
                  widget.updateDuration(currentDuration);
                },
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              flex: 1,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Seconds',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (text) {
                  int currentSeconds = text.isNotEmpty ? int.parse(text) : 0;
                  setState(() => seconds = currentSeconds);
                  updateCurrentDuration();
                  widget.updateDuration(currentDuration);
                },
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              flex: 1,
              child: TextField(
                decoration: const InputDecoration(
                    labelText: 'Milliseconds',
                    border: OutlineInputBorder(),
                    hintText: 'Milliseconds'
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (text) {
                  int currentMilliseconds = text.isNotEmpty ? int.parse(text) : 0;
                  setState(() => milliseconds = currentMilliseconds);
                  updateCurrentDuration();
                  widget.updateDuration(currentDuration);
                  },
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: isEnabled ? () {
              widget.toggleRandomizer(true);
              FocusManager.instance.primaryFocus?.unfocus();
            } : null,
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(100, 100),
              shape: const CircleBorder(),
            ),
            child: const Text('Start!')
          ),
        ),
      ],
    );
  }
}
