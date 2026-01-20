import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_chat_app/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Servicio encargado de gestionar toda la lógica del chat.
///
/// Se encarga de:
/// - Obtener usuarios
/// - Enviar mensajes
/// - Escuchar mensajes en tiempo real
class ChatService {
  /// Instancia de Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Instancia de FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // =========================
  // USUARIOS
  // =========================

  /// Obtiene todos los usuarios registrados en Firestore
  ///
  /// Devuelve una lista de mapas con la información del usuario.
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  // =========================
  // MENSAJES
  // =========================

  /// Envía un mensaje al usuario indicado
  Future<void> sendMessage(String receiverId, String message) async {
    // Usuario actual
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;

    // Marca de tiempo
    final Timestamp timestamp = Timestamp.now();

    // Crear mensaje
    final Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    // Crear ID único del chat (siempre igual para ambos usuarios)
    final List<String> ids = [currentUserId, receiverId];
    ids.sort();
    final String chatRoomId = ids.join('_');

    // Guardar mensaje en Firestore
    await _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  /// Obtiene el stream de mensajes entre dos usuarios
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    // Generar ID único del chat
    final List<String> ids = [userId, otherUserId];
    ids.sort();
    final String chatRoomId = ids.join('_');

    return _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
