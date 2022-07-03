import 'package:auto_rng/resources/colors.dart';
import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    primaryColor: ThemeColors.primaryColor,
  );
  static final dark = ThemeData.dark().copyWith(
    backgroundColor: Colors.black,
    primaryColor: ThemeColors.primaryColor,
  );
}
