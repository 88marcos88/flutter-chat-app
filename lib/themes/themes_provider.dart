import 'package:di_chat_app/themes/dark_mode.dart';
import 'package:di_chat_app/themes/light_mode.dart';
import 'package:flutter/material.dart';

/// Provider encargado de gestionar el tema de la aplicación.
///
/// Permite alternar entre:
/// - Modo claro
/// - Modo oscuro
///
/// Utiliza [ChangeNotifier] para notificar a la UI
/// cuando el tema cambia.
class ThemesProvider extends ChangeNotifier {
  /// Tema actual de la aplicación
  ThemeData _themeData = lightMode;

  /// Getter del tema actual
  ThemeData get themeData => _themeData;

  /// Indica si el tema actual es oscuro
  bool get isDarkMode => _themeData == darkMode;

  /// Establece un nuevo tema y notifica a los listeners
  set themeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  /// Alterna entre modo claro y oscuro
  void toggleTheme() {
    if (isDarkMode) {
      _themeData = lightMode;
    } else {
      _themeData = darkMode;
    }
    notifyListeners();
  }
}
