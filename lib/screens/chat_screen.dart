import 'package:flutter/material.dart';
import '../widgets/message_bubble.dart';
import '../widgets/chat_input.dart';

class ChatScreen extends StatelessWidget {
  final String name;

  const ChatScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: const [
                MessageBubble(text: 'Hola!', isMe: false),
                MessageBubble(text: 'Buenas 😄', isMe: true),
              ],
            ),
          ),
          const ChatInput(),
        ],
      ),
    );
  }
}
