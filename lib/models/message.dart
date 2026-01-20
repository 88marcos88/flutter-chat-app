import 'package:cloud_firestore/cloud_firestore.dart';

/// Modelo que representa un mensaje de chat.
///
/// Se utiliza para:
/// - Enviar mensajes a Firestore
/// - Leer mensajes desde Firestore
/// - Mantener una estructura limpia y tipada
class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  /// Convierte el objeto Message a un Map
  /// para poder guardarlo en Firestore.
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }

  /// Crea un objeto Message a partir de un Map de Firestore
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'],
      senderEmail: map['senderEmail'],
      receiverId: map['receiverId'],
      message: map['message'], // ✅ CORREGIDO
      timestamp: map['timestamp'],
    );
  }
}
