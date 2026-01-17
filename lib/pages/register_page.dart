import 'package:di_chat_app/auth/auth_service.dart';
import 'package:di_chat_app/components/my_button.dart';
import 'package:di_chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailControloller = TextEditingController();
  final TextEditingController _pswController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  // tap to go to register
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) async {
    // get auth service
    final _auth = AuthService();

    // password match -> create account
    if (_pswController.text == _confirmPwController.text) {
      try {
        _auth.singUpWithEmailPassword(
          _emailControloller.text,
          _pswController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())),
        );
      }
    }
    // password dont match -> error message
    else {
      showDialog(
        context: context,
        builder: (context) =>
            const AlertDialog(title: Text("Passwords don't match!")),
      );
    }
  }

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
            "Let's create an account!",
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

          //confirm pw textfield
          MyTextField(
            hintText: "Confirm Password",
            obscureText: true,
            controller: _confirmPwController,
          ),
          const SizedBox(height: 10),

          //login button
          MyButton(text: "Register", onTap: () => register(context)),

          const SizedBox(height: 10),

          //register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Alredy have an account? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "Login now",
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
