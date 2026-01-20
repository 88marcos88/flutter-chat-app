import 'package:flutter/material.dart';

/// Burbuja de mensaje utilizada en el chat.
///
/// Cambia su estilo dependiendo de si el mensaje
/// pertenece al usuario actual o al receptor.
class ChatBubble extends StatelessWidget {
  /// Contenido del mensaje
  final String message;

  /// Indica si el mensaje fue enviado por el usuario actual
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: isCurrentUser
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Text(
        message,
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontSize: 15,
        ),
      ),
    );
  }
}
