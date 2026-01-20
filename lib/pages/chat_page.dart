import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_chat_app/components/chat_bubble.dart';
import 'package:di_chat_app/components/my_textfield.dart';
import 'package:di_chat_app/services/auth/auth_service.dart';
import 'package:di_chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

/// Pantalla de chat entre dos usuarios.
///
/// Permite:
/// - Mostrar mensajes en tiempo real (Firestore)
/// - Enviar mensajes de texto
/// - Dictar mensajes por voz (Speech to Text)
/// - Interacción en tiempo real
class ChatPage extends StatefulWidget {
  final String reciverEmail;
  final String receiverId;

  const ChatPage({
    super.key,
    required this.reciverEmail,
    required this.receiverId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  /// Controlador del campo de texto
  final TextEditingController _messageController = TextEditingController();

  /// Instancia del motor de reconocimiento de voz
  final stt.SpeechToText _speech = stt.SpeechToText();

  /// Indica si el micrófono está activo
  bool _isListening = false;

  /// Servicios de autenticación y chat
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // -------------------------------------------------
  // MÉTODO: Activar / desactivar reconocimiento de voz
  // -------------------------------------------------
  Future<void> _toggleListening() async {
    if (!_isListening) {
      // Inicializa el reconocimiento de voz
      bool available = await _speech.initialize();

      if (available) {
        setState(() => _isListening = true);

        // Escucha la voz del usuario
        _speech.listen(
          onResult: (result) {
            setState(() {
              // El texto reconocido se escribe en el input
              _messageController.text = result.recognizedWords;
            });
          },
        );
      }
    } else {
      // Detiene el reconocimiento
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  // -------------------------
  // ENVÍO DE MENSAJES
  // -------------------------
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receiverId,
        _messageController.text,
      );

      // Limpia el campo tras enviar
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          widget.reciverEmail,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          /// Lista de mensajes
          Expanded(child: _buildMessageList()),

          /// Campo de entrada del usuario
          _buildUserInput(context),
        ],
      ),
    );
  }

  // -------------------------------------------------
  // LISTA DE MENSAJES
  // -------------------------------------------------
  Widget _buildMessageList() {
    final senderId = _authService.currentUser!.uid;

    return StreamBuilder(
      stream: _chatService.getMessages(senderId, widget.receiverId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  /// Construye una burbuja de mensaje individual
  Widget _buildMessageItem(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    final bool isCurrentUser =
        data['senderId'] == _authService.currentUser!.uid;

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ChatBubble(message: data['message'], isCurrentUser: isCurrentUser),
    );
  }

  // -------------------------------------------------
  // INPUT + BOTÓN DE VOZ
  // -------------------------------------------------
  Widget _buildUserInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50, left: 10, right: 10),
      child: Row(
        children: [
          /// Campo de texto
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: _isListening ? 'Escuchando...' : 'Type your message...',
              obscureText: false,
            ),
          ),

          const SizedBox(width: 10),

          /// Botón de reconocimiento de voz
          Container(
            decoration: BoxDecoration(
              color: _isListening ? Colors.red : Colors.teal,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                _isListening ? Icons.mic_off : Icons.mic,
                color: Colors.white,
              ),
              onPressed: _toggleListening,
            ),
          ),

          const SizedBox(width: 10),

          /// Botón de envío
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
