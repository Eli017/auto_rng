import 'package:auto_rng/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:auto_rng/services/duration_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.setTheme}) : super(key: key);

  final Function setTheme;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final DurationService durationService = DurationService();
  final ThemeService themeService = ThemeService();
  DurationType durationChoice = DurationType.traditional;
  ThemeMode themeChoice = ThemeMode.system;

  @override
  void initState() {
    durationService.getDurationType().then((DurationType value) => {
      setState(() => durationChoice = value)
    });
    themeService.getThemeType().then((ThemeMode value) => {
      setState(() => themeChoice = value),
      widget.setTheme(themeChoice)
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: themeData.primaryColor,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
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
                        color: themeData.textTheme.headline2?.color?.withOpacity(1.0),
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
          const SizedBox(height: 30),
          Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Theme Choice',
                        style: themeData.textTheme.headline2?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: themeData.textTheme.headline2?.color?.withOpacity(1.0),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Light'),
                    leading: Radio<ThemeMode>(
                        value: ThemeMode.light,
                        groupValue: themeChoice,
                        onChanged: (ThemeMode? value) {
                          setState(() => themeChoice = value!);
                          themeService.setThemeType(value!);
                          widget.setTheme(themeChoice);
                        }
                    ),
                  ),
                  ListTile(
                    title: const Text('Dark'),
                    leading: Radio<ThemeMode>(
                        value: ThemeMode.dark,
                        groupValue: themeChoice,
                        onChanged: (ThemeMode? value) {
                          setState(() => themeChoice = value!);
                          themeService.setThemeType(value!);
                          widget.setTheme(themeChoice);
                        }
                    ),
                  ),
                  ListTile(
                    title: const Text('System'),
                    leading: Radio<ThemeMode>(
                        value: ThemeMode.system,
                        groupValue: themeChoice,
                        onChanged: (ThemeMode? value) {
                          setState(() => themeChoice = value!);
                          themeService.setThemeType(value!);
                          widget.setTheme(themeChoice);
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