import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:di_chat_app/components/my_textfield.dart';
import 'package:di_chat_app/services/auth/auth_service.dart';
import 'package:di_chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String reciverEmail;
  final String receiverId;

  ChatPage({super.key, required this.reciverEmail, required this.receiverId});

  // Text controller
  final TextEditingController _messageController = TextEditingController();

  //chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // send message
  void sendMessage() async {
    // if there is something inside the text field
    if (_messageController.text.isNotEmpty) {
      // send the message
      await _chatService.sendMessage(receiverId, _messageController.text);

      // clear the text field
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text('Chat with $reciverEmail')),
      body: Column(
        children: [
          // display alll messages
          Expanded(child: _buildUserList()),
          // user input
          _buildUserInput(),
        ],
      ),
    );
  }

  // build a list of messages between current user and selected user
  Widget _buildUserList() {
    String senderId = _authService.currentUser!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(senderId, receiverId),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // return list of messages
        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data['senderId'] == _authService.currentUser!.uid;

    // align to right if current user is sender
    var alignment = isCurrentUser
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [Text(data['message'])],
      ),
    );
  }

  // build user input
  Widget _buildUserInput() {
    return Row(
      children: [
        // text field take up most of the space
        Expanded(
          child: MyTextField(
            controller: _messageController,
            hintText: 'Type your message here...',
            obscureText: false,
          ),
        ),
        // send button
        IconButton(icon: Icon(Icons.send), onPressed: sendMessage),
      ],
    );
  }
}
