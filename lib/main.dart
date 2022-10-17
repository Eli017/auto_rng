import 'package:auto_rng/pages/home_page.dart';
import 'package:auto_rng/resources/themes.dart';
import 'package:auto_rng/services/theme_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeService themeService = ThemeService();
  ThemeMode themeChoice = ThemeMode.system;

  @override
  void initState() {
    themeService.getThemeType().then((ThemeMode value) => {
      setState(() => themeChoice = value)
    });
    super.initState();
  }

  void setThemeState(ThemeMode themeMode) {
    setState(() => themeChoice = themeMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Mix',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: themeChoice,
      debugShowCheckedModeBanner: false,
      home: HomePage(setTheme: setThemeState),
    );
  }
}
