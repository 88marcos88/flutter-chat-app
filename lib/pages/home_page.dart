import 'package:di_chat_app/components/my_drawer.dart';
import 'package:di_chat_app/components/user_tile.dart';
import 'package:di_chat_app/pages/chat_page.dart';
import 'package:di_chat_app/services/auth/auth_service.dart';
import 'package:di_chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

/// Pantalla principal de la aplicación.
///
/// Muestra la lista de usuarios disponibles para chatear
/// (excepto el usuario actualmente autenticado).
class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Servicios
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Home"),
      ),

      drawer: const MyDrawer(),

      body: _buildUserList(),
    );
  }

  /// Construye la lista de usuarios obtenida desde Firestore
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        // Error
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // Cargando datos
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Lista de usuarios
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  /// Construye cada usuario de la lista
  ///
  /// Evita mostrar el usuario actualmente logueado
  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    final currentUser = _authService.currentUser;

    // No mostrar al usuario actual
    if (currentUser != null && userData["email"] != currentUser.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          // Navega al chat con el usuario seleccionado
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                reciverEmail: userData['email'],
                receiverId: userData['uid'],
              ),
            ),
          );
        },
      );
    }

    return const SizedBox.shrink();
  }
}
