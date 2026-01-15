import 'package:di_chat_app/components/my_button.dart';
import 'package:di_chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  //email and pw text controllers
  final TextEditingController _emailControloller = TextEditingController();
  final TextEditingController _pswController = TextEditingController();

  // tap to go to register
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});
  void login() {}

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
          MyTextField(
            hintText: "Email",
            obscureText: false,
            controller: _emailControloller,
          ),

          //pw textfield
          MyTextField(
            hintText: "Password",
            obscureText: true,
            controller: _pswController,
          ),
          const SizedBox(height: 10),

          //login button
          MyButton(text: "Login", onTap: login),

          const SizedBox(height: 10),

          //register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not a member? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "register now",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
