import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_chat_app/components/chat_bubble.dart';
import 'package:di_chat_app/components/my_textfield.dart';
import 'package:di_chat_app/services/auth/auth_service.dart';
import 'package:di_chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

/// Pantalla de chat entre dos usuarios.
///
/// Muestra el historial de mensajes y permite enviar nuevos.
/// Se conecta a Firestore en tiempo real.
class ChatPage extends StatelessWidget {
  final String reciverEmail;
  final String receiverId;

  ChatPage({super.key, required this.reciverEmail, required this.receiverId});

  /// Controlador del input de mensajes
  final TextEditingController _messageController = TextEditingController();

  /// Servicios
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  /// Envía un mensaje al usuario seleccionado
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverId, _messageController.text);

      // Limpia el campo de texto tras enviar
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(reciverEmail),
      ),

      body: Column(
        children: [
          // Lista de mensajes
          Expanded(child: _buildMessageList()),

          // Input del usuario
          _buildUserInput(context),
        ],
      ),
    );
  }

  /// Construye la lista de mensajes entre los dos usuarios
  Widget _buildMessageList() {
    final String senderId = _authService.currentUser!.uid;

    return StreamBuilder(
      stream: _chatService.getMessages(senderId, receiverId),
      builder: (context, snapshot) {
        // Error
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // Cargando mensajes
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Lista de mensajes
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  /// Construye cada burbuja de mensaje
  Widget _buildMessageItem(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Comprueba si el mensaje es del usuario actual
    final bool isCurrentUser =
        data['senderId'] == _authService.currentUser!.uid;

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ChatBubble(message: data['message'], isCurrentUser: isCurrentUser),
    );
  }

  /// Input para escribir y enviar mensajes
  Widget _buildUserInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50, left: 10, right: 10),
      child: Row(
        children: [
          // Campo de texto
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: 'Type your message...',
              obscureText: false,
            ),
          ),

          const SizedBox(width: 10),

          // Botón enviar
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
