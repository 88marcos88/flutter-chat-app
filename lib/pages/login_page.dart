import 'package:di_chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          //logo
          Image.asset('assets/images/logo.png'),

          //welcomeback message
          Text(
            "Welcome back you've been missed!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),

          //email textfield
          MyTextField(hintText: "Email", obscureText: false),

          //pw textfield
          MyTextField(hintText: "Password", obscureText: true),
          const SizedBox(height: 10),

          //login button

          //register now
        ],
      ),
    );
  }
}
