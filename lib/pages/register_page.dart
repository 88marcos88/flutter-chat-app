import 'package:di_chat_app/services/auth/auth_service.dart';
import 'package:di_chat_app/components/my_button.dart';
import 'package:di_chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

/// Pantalla de registro de usuario.
///
/// Permite crear una nueva cuenta usando email y contraseña.
/// Valida que ambas contraseñas coincidan antes de crear el usuario.
class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pswController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  /// Callback para volver a la pantalla de login
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  /// Registra un nuevo usuario en Firebase
  void register(BuildContext context) async {
    final auth = AuthService();

    // Comprobar que las contraseñas coinciden
    if (_pswController.text == _confirmPwController.text) {
      try {
        await auth.signUpWithEmailPassword(
          _emailController.text,
          _pswController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Register error"),
            content: Text(e.toString()),
          ),
        );
      }
    } else {
      // Contraseñas no coinciden
      showDialog(
        context: context,
        builder: (context) =>
            const AlertDialog(title: Text("Passwords don't match")),
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
          // Logo
          Semantics(
            label: 'Logotipo de la aplicación',
            image: true,
            child: Image.asset('assets/images/logo.png'),
          ),

          const SizedBox(height: 20),

          // Texto informativo
          Semantics(
            label: 'Mensaje informativo de registro',
            child: Text(
              "Let's create an account!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Email
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

          // Password
          Semantics(
            label: 'Campo para introducir la contraseña',
            textField: true,
            child: MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _pswController,
            ),
          ),

          const SizedBox(height: 10),

          // Confirm password
          Semantics(
            label: 'Campo para confirmar la contraseña',
            textField: true,
            child: MyTextField(
              hintText: "Confirm Password",
              obscureText: true,
              controller: _confirmPwController,
            ),
          ),

          const SizedBox(height: 15),

          // Register button
          Semantics(
            label: 'Botón para registrarse en la aplicación',
            button: true,
            child: MyButton(text: "Register", onTap: () => register(context)),
          ),

          const SizedBox(height: 15),

          // Volver al login
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              Semantics(
                label: 'Volver a la pantalla de inicio de sesión',
                button: true,
                child: GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    "Login now",
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
