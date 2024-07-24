

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:application/pages/home.dart';
import 'package:application/pages/message.dart';
import 'package:application/pages/add.dart';
import 'package:application/pages/notifications.dart';
import 'package:application/pages/personal.dart';
import 'package:application/pages/login.dart';
import 'package:application/services/auth_service.dart';

class NavBar extends StatefulWidget {
  static const String id = "navbar";

  final String username;
  final String fullName;
  final String email; // Ajoutez ce champ pour l'email
  const NavBar(
      {super.key,
      required this.username,
      required this.fullName,
      required this.email});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final AuthService _authService = AuthService(); // Instance du service

  void _logout(BuildContext context) async {
    // Afficher la boîte de dialogue de confirmation
    bool? confirmLogout = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout Confirmation'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmLogout == true) {
      var result = await _authService.logout(widget.username);

      if (result['success']) {
        // Rediriger vers la page de login
        Navigator.pushReplacementNamed(context, LoginPage.id);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout Failed: ${result['message']}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Home(username: widget.username),
      const MessagePage(),
      const AddPage(),
      const NotificationsPage(),
      const PersonalPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche
          children: [
            Text(
              "Welcome, ${widget.fullName}",
              style: const TextStyle(
                fontSize: 20, // Ajustez la taille selon vos besoins
              ),
            ),
            Text(
              "${widget.email}", // Affichez l'email
              style: const TextStyle(
                fontSize: 14, // Taille plus petite pour l'email
                // color: Colors.white70, // Couleur légèrement différente
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: const Color.fromARGB(255, 82, 39, 176),
        color: Colors.purple,
        animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Icon(Icons.home, size: 26, color: Colors.white),
          Icon(Icons.message, size: 26, color: Colors.white),
          Icon(Icons.add, size: 26, color: Colors.white),
          Icon(Icons.notifications, size: 26, color: Colors.white),
          Icon(Icons.person, size: 26, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: _pages[_page],
    );
  }
}
