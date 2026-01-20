import 'package:flutter/material.dart';

/// Campo de texto reutilizable para formularios.
///
/// Se utiliza en:
/// - Login
/// - Registro
/// - Chat
///
/// Permite personalizar:
/// - Texto de ayuda
/// - Si el texto es oculto (password)
/// - Controlador del input
class MyTextField extends StatelessWidget {
  /// Texto que se muestra como placeholder
  final String hintText;

  /// Indica si el texto debe ocultarse (password)
  final bool obscureText;

  /// Controlador del campo de texto
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,

        decoration: InputDecoration(
          // Borde cuando no está enfocado
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),

          // Borde cuando está enfocado
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          // Fondo del input
          filled: true,
          fillColor: Theme.of(context).colorScheme.secondary,

          // Texto de ayuda
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
