import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmpwController = TextEditingController();

  Future<void> register(BuildContext context) async {
    final _auth = AuthService();

    if (_pwController.text == _confirmpwController.text) {
      try {
        await _auth.signUpWithEmailPassword(
          _emailController.text,
          _pwController.text,
        );
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Registration Successful"),
          ),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error"),
            content: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords don't match!"),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _confirmpwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // logo
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 10),
          // App name
          Text(
            "ChitChat",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          // Welcome message
          Text(
            "Let's create an account",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 25),
          // Email textfield
          MyTextfield(
            hintText: "Email",
            obscureText: false,
            controller: _emailController,
          ),
          const SizedBox(height: 10),
          // Password textfield
          MyTextfield(
            hintText: "Password",
            obscureText: true,
            controller: _pwController,
          ),
          const SizedBox(height: 10),
          // Confirm password textfield
          MyTextfield(
            hintText: "Confirm password",
            obscureText: true,
            controller: _confirmpwController,
          ),
          const SizedBox(height: 25),
          // Register button
          MyButton(
            text: "Register",
            onTap: () => register(context),
          ),
          const SizedBox(height: 25),
          // Login prompt
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: Text(
                  "Login now",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
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
