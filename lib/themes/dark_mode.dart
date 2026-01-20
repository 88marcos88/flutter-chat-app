import 'package:flutter/material.dart';

/// 🎨 Colores principales del modo oscuro
///
/// Paleta con tonos morados oscuros y rosados suaves,
/// pensada para una experiencia nocturna agradable
/// sin perder contraste ni legibilidad.

// Fondo principal oscuro
const deepPurple = Color(0xFF1A0F24);

// Color principal (botones, elementos activos)
const winePurple = Color(0xFF7A3B5A);

// Color secundario (contenedores, tarjetas)
const darkGrape = Color(0xFF2D143C);

// Color de acento suave
const softPink = Color(0xFFD6A3B5);

/// Tema oscuro de la aplicación
///
/// Se activa cuando el usuario habilita el modo oscuro
/// desde la pantalla de ajustes.
final ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.dark(
    background: deepPurple,
    primary: winePurple,
    secondary: darkGrape,
    tertiary: softPink,
    inversePrimary: Colors.white,
  ),
);
