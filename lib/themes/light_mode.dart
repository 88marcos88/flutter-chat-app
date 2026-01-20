import 'package:flutter/material.dart';

/// 🎨 Colores principales de la aplicación (modo claro)
///
/// Paleta inspirada en tonos suaves y rosados,
/// pensada para una interfaz agradable y moderna.

// Color principal de fondo
const sakuraPink = Color(0xFFF9CFE1);

// Color principal de elementos activos
const cherryRose = Color(0xFFC86A7A);

// Color secundario (contraste)
const darkCherry = Color(0xFF8F4350);

// Color claro para tarjetas y superficies
const milkWhite = Color(0xFFFBE9E8);

/// Tema claro de la aplicación
///
/// Se utiliza cuando el usuario no tiene activado
/// el modo oscuro.
final ThemeData lightMode = ThemeData(
  colorScheme: const ColorScheme.light(
    background: sakuraPink,
    primary: cherryRose,
    secondary: darkCherry,
    tertiary: milkWhite,
    inversePrimary: Colors.black,
  ),
);
