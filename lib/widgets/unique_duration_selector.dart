import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../helpers/time_conversion.dart';

class UniqueDurationSelector extends StatefulWidget {
  final Function(int) updateDuration;
  final Function(bool) toggleRandomizer;

  const UniqueDurationSelector({
    Key? key,
    required this.updateDuration,
    required this.toggleRandomizer,
  }) : super(key: key);

  @override
  State<UniqueDurationSelector> createState() => _UniqueDurationSelectorState();
}

class _UniqueDurationSelectorState extends State<UniqueDurationSelector>  {
  int times = 0;
  int currentDuration = 0;
  TimeDenominatorType timeDenominatorType = TimeDenominatorType.second;
  bool isEnabled = false;

  void updateCurrentDuration() {
    int newMilliseconds = convertTimePerDuration(times, timeDenominatorType);
    setState(() => currentDuration = newMilliseconds);
    //Every frame within 60fps is approximately 16.3 milliseconds.
    //Therefore, this app must have a function delay of at least 17 seconds.
    if (currentDuration > 0) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(flex: 2, child: SizedBox()),
            Flexible(
              flex: 1,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Times',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (text) {
                  int currentTimes = text.isNotEmpty ? int.parse(text) : 0;
                  setState(() => times = currentTimes);
                  updateCurrentDuration();
                  widget.updateDuration(currentDuration);
                },
              ),
            ),
            const Flexible(flex: 2, child: SizedBox()),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Per: '),
              const SizedBox(width: 10),
              DropdownButton<TimeDenominatorType>(
                value: timeDenominatorType,
                items: [
                  DropdownMenuItem(
                    value: TimeDenominatorType.second,
                    child: Text(TimeDenominatorType.second.name),
                  ),
                  DropdownMenuItem(
                    value: TimeDenominatorType.minute,
                    child: Text(TimeDenominatorType.minute.name),
                  ),
                  DropdownMenuItem(
                    value: TimeDenominatorType.hour,
                    child: Text(TimeDenominatorType.hour.name),
                  )
                ],
                onChanged: (TimeDenominatorType? value) {
                  setState(() => timeDenominatorType = value!);
                }
              ),
            ],
          ),
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
