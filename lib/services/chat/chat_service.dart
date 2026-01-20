import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_chat_app/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  // get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user stream
  /*
  Stream<List<Map<String, dynamic> =

  [{
    'email': 'test@gmail.com'
    'id': 'asdasdasd123123'
  },
  { 
    'email': 'test2@gmail.com',
    'id': 'asdasdasd123124'
  },]

  */
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go through each individual user
        final user = doc.data();
        // return user
        return user;
      }).toList();
    });
  }

  //send message

  Future<void> sendMessage(String receiverId, message) async {
    // get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    // construct chat room ID for the two users
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // sort to ensure consistent order
    String chatRoomId = ids.join('_');

    // add new meassage to the database
    await _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //get messages stream
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    // construct chat room ID for the two users
    List<String> ids = [userId, otherUserId];
    ids.sort(); // sort to ensure consistent order
    String chatRoomId = ids.join('_');

    return _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
