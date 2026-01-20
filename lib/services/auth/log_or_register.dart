import 'package:di_chat_app/pages/login_page.dart';
import 'package:di_chat_app/pages/register_page.dart';
import 'package:flutter/material.dart';

/// Widget que controla si se muestra la pantalla de
/// inicio de sesión o la de registro.
///
/// Funciona como un "switch" visual entre ambas pantallas
/// sin necesidad de navegación.
class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  /// Indica si se debe mostrar la pantalla de login.
  ///
  /// - true  → Login
  /// - false → Registro
  bool showLoginPage = true;

  /// Alterna entre login y registro.
  ///
  /// Este método se pasa como callback a las pantallas
  /// para que ellas mismas puedan cambiar la vista.
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Si showLoginPage es true, muestra LoginPage
    // Si es false, muestra RegisterPage
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
