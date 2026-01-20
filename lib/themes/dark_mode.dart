import 'package:flutter/material.dart';

// FNG COLORS
// FNG DARK COLORS
const deepPurple = Color(0xFF1A0F24);
const winePurple = Color(0xFF7A3B5A);
const darkGrape = Color(0xFF2D143C);
const softPink = Color(0xFFD6A3B5);

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    background: deepPurple,
    primary: winePurple,
    secondary: darkGrape,
    tertiary: softPink,
    inversePrimary: Colors.white,
  ),
);
