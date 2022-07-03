import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  void setThemeType(ThemeMode type) async {
    SharedPreferences themePref = await SharedPreferences.getInstance();
    themePref.setString('theme_type', type.name);
  }

  Future<ThemeMode> getThemeType() async {
    SharedPreferences themePref = await SharedPreferences.getInstance();
    String? themeString = themePref.getString('theme_type');
    ThemeMode themeSaved = ThemeMode.values.byName(themeString ?? 'system');
    return themeSaved;
  }
}