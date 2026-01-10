import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: 'Escribe un mensaje...'),
            ),
          ),
          IconButton(icon: const Icon(Icons.send), onPressed: () {}),
        ],
      ),
    );
  }
}
