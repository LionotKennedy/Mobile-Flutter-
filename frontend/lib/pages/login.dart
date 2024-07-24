import 'package:flutter/material.dart';
import 'package:application/components/textfield.dart';
import 'package:application/components/button.dart';
import 'package:application/pages/navbar.dart';
import 'package:application/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  static const String id = "login";

  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> signUserIn(BuildContext context) async {
    String email = usernameController.text;
    String password = passwordController.text;

    var result = await _authService.login(email, password);

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully connected to the database'),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NavBar(
            username: email,
            fullName: result['user']['fullName'],
            email: email, // Passez l'email ici
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Failed: ${result['message']}'),
        ),
      );
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Failed'),
          content: Text(result['message']),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock,
                size: 50,
              ),
              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              MyTextField(
                controller: usernameController,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              Button(
                onTap: () => signUserIn(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
