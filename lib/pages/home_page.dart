import 'package:di_chat_app/components/my_drawer.dart';
import 'package:di_chat_app/components/user_tile.dart';
import 'package:di_chat_app/pages/chat_page.dart';
import 'package:di_chat_app/services/auth/auth_service.dart';
import 'package:di_chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("Home"),
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  // build a list of users except the current user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  //build individual list titel for user
  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    //display all users except current user
    final currentUser = _authService.currentUser;
    if (currentUser != null && userData["email"] != currentUser.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          //navigate to chat page with selected user
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                reciverEmail: userData['email'],
                receiverId: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
