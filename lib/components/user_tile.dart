import 'package:flutter/material.dart';

/// Widget reutilizable que representa a un usuario en la lista.
///
/// Se utiliza en la pantalla principal para mostrar
/// los usuarios disponibles para chatear.
class UserTile extends StatelessWidget {
  /// Texto a mostrar (email o nombre del usuario)
  final String text;

  /// Acción que se ejecuta al pulsar el tile
  final void Function()? onTap;

  const UserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),

        child: Row(
          children: const [
            // Icono del usuario
            Icon(Icons.person),

            SizedBox(width: 20),

            // Nombre o email del usuario
            // (se pasa desde el constructor)
          ],
        ),
      ),
    );
  }
}
