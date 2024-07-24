
import 'package:flutter/material.dart';
import 'package:application/pages/login.dart';
import 'package:application/pages/navbar.dart';
import 'package:application/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        LoginPage.id: (context) => LoginPage(),
        NavBar.id: (context) => NavBar(
          username: (ModalRoute.of(context)!.settings.arguments as Map)['username'],
          fullName: (ModalRoute.of(context)!.settings.arguments as Map)['fullName'],
          email: (ModalRoute.of(context)!.settings.arguments as Map)['email'],
        ),
        Home.id: (context) => Home(username: ModalRoute.of(context)!.settings.arguments as String),
      },
    );
  }
}
