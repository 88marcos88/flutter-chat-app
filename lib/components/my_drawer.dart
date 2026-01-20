import 'package:di_chat_app/services/auth/auth_service.dart';
import 'package:di_chat_app/pages/settings_page.dart';
import 'package:flutter/material.dart';

/// Drawer principal de la aplicación.
///
/// Contiene:
/// - Acceso a Home
/// - Acceso a Settings
/// - Cierre de sesión
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  /// Cierra la sesión del usuario actual
  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Parte superior del drawer
          Column(
            children: [
              // Logo / icono principal
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
              ),

              // Opción HOME
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("H O M E"),
                  onTap: () {
                    // Cierra el drawer
                    Navigator.pop(context);
                  },
                ),
              ),

              // Opción SETTINGS
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("S E T T I N G S"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          /// Opción LOGOUT
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("L O G O U T"),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
