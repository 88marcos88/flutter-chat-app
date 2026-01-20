import 'package:di_chat_app/services/auth/auth_service.dart';
import 'package:di_chat_app/components/my_button.dart';
import 'package:di_chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

/// Pantalla de inicio de sesión.
///
/// Permite al usuario iniciar sesión mediante email y contraseña.
/// Utiliza el servicio [AuthService] para comunicarse con Firebase.
class LoginPage extends StatelessWidget {
  // Controladores para los campos de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pswController = TextEditingController();

  /// Callback para cambiar a la pantalla de registro
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  /// Ejecuta el inicio de sesión del usuario
  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailAndPassword(
        _emailController.text,
        _pswController.text,
      );
    } catch (e) {
      // Muestra un diálogo de error si falla el login
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Login error"),
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo de la app
          Semantics(
            label: 'Logotipo de la aplicación',
            image: true,
            child: Image.asset('assets/images/logo.png'),
          ),

          const SizedBox(height: 20),

          // Mensaje de bienvenida
          Semantics(
            label: 'Mensaje de bienvenida',
            child: Text(
              "Welcome back, you've been missed!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Campo email
          Semantics(
            label: 'Campo para introducir el correo electrónico',
            textField: true,
            child: MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),
          ),

          const SizedBox(height: 10),

          // Campo contraseña
          Semantics(
            label: 'Campo para introducir la contraseña',
            textField: true,
            child: MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _pswController,
            ),
          ),
          const SizedBox(height: 15),

          // Botón login
          Semantics(
            label: 'Botón para iniciar sesión',
            button: true,
            child: MyButton(text: "Login", onTap: () => login(context)),
          ),

          const SizedBox(height: 15),

          // Enlace a registro
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              Semantics(
                label: 'Acceder a la pantalla de registro',
                button: true,
                child: GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    "Register now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
