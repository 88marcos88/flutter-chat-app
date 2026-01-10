import 'package:flutter/material.dart';

// FNG COLORS
const sakuraPink = Color(0xFFF9CFE1);
const cherryRose = Color(0xFFC86A7A);
const darkCherry = Color(0xFF8F4350);
const milkWhite = Color(0xFFFBE9E8);

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: sakuraPink,
    primary: cherryRose,
    secondary: darkCherry,
    tertiary: milkWhite,
    inversePrimary: Colors.black,
  ),
);
