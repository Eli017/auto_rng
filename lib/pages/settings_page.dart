import 'package:flutter/material.dart';
import 'package:auto_rng/services/duration_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SettingsPage(),
      settings: const RouteSettings(name: '/settingsPage'),
    );
  }

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final DurationService durationService = DurationService();
  DurationType durationChoice = DurationType.traditional;

  @override
  void initState() {
    durationService.getDurationType().then((DurationType value) => {
      setState(() => durationChoice = value)
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Duration Choice',
                      style: themeData.textTheme.headline2?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Traditional'),
                  subtitle: const Text('Choose the duration with specific duration'),
                  leading: Radio<DurationType>(
                      value: DurationType.traditional,
                      groupValue: durationChoice,
                      onChanged: (DurationType? value) {
                        setState(() => durationChoice = value!);
                        durationService.setDurationType(value!);
                      }
                  ),
                ),
                ListTile(
                  title: const Text('Unique'),
                  subtitle: const Text('Choose the duration by X times in X time period'),
                  leading: Radio<DurationType>(
                      value: DurationType.unique,
                      groupValue: durationChoice,
                      onChanged: (DurationType? value) {
                        setState(() => durationChoice = value!);
                        durationService.setDurationType(value!);
                      }
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}