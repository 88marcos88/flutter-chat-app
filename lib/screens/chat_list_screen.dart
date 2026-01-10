import 'package:flutter/material.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chats')),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(child: Text('A')),
            title: const Text('Ana'),
            subtitle: const Text('Hola! ¿Qué tal?'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChatScreen(name: 'Ana'),
                ),
              );
            },
          ),
          ListTile(
            leading: const CircleAvatar(child: Text('M')),
            title: const Text('Marcos'),
            subtitle: const Text('Nos vemos luego'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChatScreen(name: 'Marcos'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
