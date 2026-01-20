import 'package:flutter/material.dart';

/// Botón reutilizable de la aplicación.
///
/// Se utiliza en:
/// - Login
/// - Registro
/// - Cualquier acción principal
///
/// Permite personalizar:
/// - Texto
/// - Acción al pulsar
class MyButton extends StatelessWidget {
  /// Texto que se muestra dentro del botón
  final String text;

  /// Función que se ejecuta al pulsar el botón
  final void Function()? onTap;

  const MyButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.all(25),

        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),

        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
