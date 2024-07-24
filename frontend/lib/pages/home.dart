import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static const String id = "home";

  final String username;

  const Home({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: Center(
          // child: Text("Home, $username"),
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
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // showDialog(
            //     context: context,
            //     builder: (context) {
            //       return AlertDialog(
            //         title: const Text('Add piste'),
            //         // children: [
            //         // child: Container()

            //         content: TextFormField(
            //           decoration: const InputDecoration(
            //             labelText: 'Item name',
            //           ),
            //         ),

            //         // ],
            //         actions: [
            //           TextButton(
            //             onPressed: () {
            //               Navigator.pop(context);
            //             },
            //             child: const Text('Cancel'),
            //           ),
            //           TextButton(
            //             onPressed: () {
            //               Navigator.pop(context);
            //             },
            //             child: const Text('Add'),
            //           ),
            //         ],
            //       );
            //     });
            showGeneralDialog(
                // let's close the dialog
                barrierDismissible: true,
                context: context,
                pageBuilder: (context, _, __) => Center(
                    child: Container(
                        height: 620,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))))));
          },
          // color: Colors.purple,
          child: const Icon(Icons.add),
        ));
  }
}
