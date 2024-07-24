// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function()? onTap;
 const Button({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          // color: Colors.black,
          gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 223, 3, 201),
                Color.fromARGB(255, 5, 12, 212),
              ]),

          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Sign In",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
















// import 'package:flutter/material.dart';

// class Button extends StatelessWidget {
//   final VoidCallback onTap;

//   Button({required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onTap,
//       child: Text('Login'),
//     );
//   }
// }
