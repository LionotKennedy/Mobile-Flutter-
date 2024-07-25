// import 'package:flutter/material.dart';
// import 'package:application/components/modal_piste/piste_modal.dart'; // Assurez-vous que le chemin est correct
// import 'package:application/services/piste_service.dart'; // Assurez-vous que le chemin est correct

// class Home extends StatefulWidget {
//   static const String id = "home";
//   final String username;

//   const Home({super.key, required this.username});

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   List<dynamic> pistes = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchPistes();
//   }

//   Future<void> _fetchPistes() async {
//     List<dynamic> fetchedPistes = await PisteService.getPistes();
//     setState(() {
//       pistes = fetchedPistes;
//     });
//   }

//   void _showPisteModal() async {
//     final result = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(40),
//           ),
//           child: const PisteModal(), // Utilisation du modal défini
//         );
//       },
//     );

//     if (result == true) {
//       _fetchPistes(); // Actualise la liste si une piste a été ajoutée
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: pistes.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(pistes[index]['pisteName']),
//                     subtitle: Text(pistes[index]['pisteStatus']),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           color: Colors.blue, // Couleur de l'icône d'édition
//                           onPressed: () {
//                             // Vous pouvez ajouter une fonctionnalité ici plus tard
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           color: Colors.red, // Couleur de l'icône de suppression
//                           onPressed: () {
//                             // Vous pouvez ajouter une fonctionnalité ici plus tard
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showPisteModal,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }









// import 'package:flutter/material.dart';
// import 'package:application/components/modal_piste/piste_modal.dart'; // Assurez-vous que le chemin est correct
// import 'package:application/services/piste_service.dart'; // Assurez-vous que le chemin est correct

// class Home extends StatefulWidget {
//   static const String id = "home";
//   final String username;

//   const Home({super.key, required this.username});

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   List<dynamic> pistes = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchPistes();
//   }

//   Future<void> _fetchPistes() async {
//     List<dynamic> fetchedPistes = await PisteService.getPistes();
//     setState(() {
//       pistes = fetchedPistes;
//     });
//   }

//   void _showPisteModal() async {
//     final result = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(40),
//           ),
//           child: const PisteModal(), // Utilisation du modal défini
//         );
//       },
//     );

//     if (result == true) {
//       _fetchPistes(); // Actualise la liste si une piste a été ajoutée
//     }
//   }

//   Future<void> _deletePiste(String pisteId) async {
//     final response = await PisteService.deletePiste(pisteId);
//     if (response['success']) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Piste deleted successfully')),
//       );
//       _fetchPistes(); // Recharger les pistes après suppression
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(response['message'])),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: pistes.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(pistes[index]['pisteName']),
//                     subtitle: Text(pistes[index]['pisteStatus']),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           color: Colors.blue, // Couleur de l'icône d'édition
//                           onPressed: () {
//                             // Vous pouvez ajouter une fonctionnalité ici plus tard
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           color: Colors.red, // Couleur de l'icône de suppression
//                           onPressed: () {
//                             _deletePiste(pistes[index]['_id']);
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showPisteModal,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:application/components/modal_piste/piste_modal.dart'; // Assurez-vous que le chemin est correct
// import 'package:application/services/piste_service.dart'; // Assurez-vous que le chemin est correct

// class Home extends StatefulWidget {
//   static const String id = "home";
//   final String username;

//   const Home({super.key, required this.username});

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   List<dynamic> pistes = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchPistes();
//   }

//   Future<void> _fetchPistes() async {
//     List<dynamic> fetchedPistes = await PisteService.getPistes();
//     setState(() {
//       pistes = fetchedPistes;
//     });
//   }

//   void _showPisteModal() async {
//     final result = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(40),
//           ),
//           child: const PisteModal(), // Utilisation du modal défini
//         );
//       },
//     );

//     if (result == true) {
//       _fetchPistes(); // Actualise la liste si une piste a été ajoutée
//     }
//   }

//   Future<void> _confirmDeletePiste(String pisteId) async {
//     bool? confirmDelete = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Confirm Deletion'),
//           content: const Text('Are you sure you want to delete this piste?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(false); // Annuler la suppression
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(true); // Confirmer la suppression
//               },
//               child: const Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );

//     if (confirmDelete == true) {
//       _deletePiste(pisteId);
//     }
//   }

//   Future<void> _deletePiste(String pisteId) async {
//     final response = await PisteService.deletePiste(pisteId);
//     if (response['success']) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Piste deleted successfully')),
//       );
//       _fetchPistes(); // Recharger les pistes après suppression
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(response['message'])),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: pistes.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(pistes[index]['pisteName']),
//                     subtitle: Text(pistes[index]['pisteStatus']),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           color: Colors.blue, // Couleur de l'icône d'édition
//                           onPressed: () {
//                             // Vous pouvez ajouter une fonctionnalité ici plus tard
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           color: Colors.red, // Couleur de l'icône de suppression
//                           onPressed: () {
//                             _confirmDeletePiste(pistes[index]['_id']);
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showPisteModal,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:application/components/modal_piste/piste_modal.dart'; // Assurez-vous que le chemin est correct
import 'package:application/components/modal_piste/update_modal.dart'; // Assurez-vous que le chemin est correct
import 'package:application/services/piste_service.dart'; // Assurez-vous que le chemin est correct

class Home extends StatefulWidget {
  static const String id = "home";
  final String username;

  const Home({super.key, required this.username});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> pistes = [];

  @override
  void initState() {
    super.initState();
    _fetchPistes();
  }

  Future<void> _fetchPistes() async {
    List<dynamic> fetchedPistes = await PisteService.getPistes();
    setState(() {
      pistes = fetchedPistes;
    });
  }

  void _showPisteModal() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: const PisteModal(), // Utilisation du modal défini
        );
      },
    );

    if (result == true) {
      _fetchPistes(); // Actualise la liste si une piste a été ajoutée
    }
  }

  void _showUpdateModal(String pisteId) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: UpdateModal(pisteId: pisteId),
        );
      },
    );

    if (result == true) {
      _fetchPistes(); // Actualise la liste si une piste a été modifiée
    }
  }

  Future<void> _confirmDeletePiste(String pisteId) async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this piste?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Annuler la suppression
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirmer la suppression
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      _deletePiste(pisteId);
    }
  }

  Future<void> _deletePiste(String pisteId) async {
    final response = await PisteService.deletePiste(pisteId);
    if (response['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Piste deleted successfully')),
      );
      _fetchPistes(); // Recharger les pistes après suppression
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: pistes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(pistes[index]['pisteName']),
                    subtitle: Text(pistes[index]['pisteStatus']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          color: Colors.blue, // Couleur de l'icône d'édition
                          onPressed: () {
                            _showUpdateModal(pistes[index]['_id']);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red, // Couleur de l'icône de suppression
                          onPressed: () {
                            _confirmDeletePiste(pistes[index]['_id']);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showPisteModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}


