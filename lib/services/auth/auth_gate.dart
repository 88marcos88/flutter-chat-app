import 'package:di_chat_app/services/auth/log_or_register.dart';
import 'package:di_chat_app/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Widget que actúa como **puerta de entrada** de la aplicación.
///
/// Se encarga de:
/// - Escuchar el estado de autenticación del usuario
/// - Redirigir automáticamente al usuario:
///   - A la pantalla principal si está logueado
///   - A login/registro si no lo está
///
/// Este enfoque evita comprobaciones manuales y hace
/// que la app reaccione en tiempo real a los cambios de sesión.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        // Stream que emite cambios de autenticación
        stream: FirebaseAuth.instance.authStateChanges(),

        builder: (context, snapshot) {
          // ✅ Usuario autenticado
          if (snapshot.hasData) {
            return HomePage();
          }

          //  Usuario NO autenticado
          return const LoginOrRegister();
        },
      ),
    );
  }
}
