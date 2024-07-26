// import 'package:flutter/material.dart';
// import 'package:application/services/piste_service.dart'; // Assurez-vous que le chemin est correct
// import 'package:application/services/vol_service.dart'; // Assurez-vous que le chemin est correct
// import 'package:application/components/modal_vol/vol_modal.dart'; // Assurez-vous d'importer le fichier correctement

// // class MessagePage extends StatelessWidget {
// //   const MessagePage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Messages"),
// //       ),
// //       body: const Center(
// //         child: Text("Messages Page"),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () async {
// //           final result = await showDialog(
// //             context: context,
// //             builder: (BuildContext context) {
// //               return Dialog(
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(40),
// //                 ),
// //                 child: const VolModal(),
// //               );
// //             },
// //           );

// //           if (result == true) {
// //             // Rafraîchir la page ou effectuer une action après l'ajout d'un vol
// //           }
// //         },
// //         child: const Icon(Icons.add),
// //       ),
// //     );
// //   }
// // }

// // class MessagePage extends StatefulWidget {
// //   const MessagePage({super.key});

// //   @override
// //   _MessagePageState createState() => _MessagePageState();
// // }

// // class _MessagePageState extends State<MessagePage> {
// //   List<dynamic> pistes = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchPistes();
// //   }

// //   Future<void> _fetchPistes() async {
// //     List<dynamic> fetchedPistes = await PisteService.getPistes();
// //     setState(() {
// //       pistes = fetchedPistes;
// //     });
// //   }

// //   void _showVolModal() async {
// //     final result = await showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return Dialog(
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(40),
// //           ),
// //           child: VolModal(pistes: pistes),
// //         );
// //       },
// //     );

// //     if (result == true) {
// //       // Rafraîchir la page ou effectuer une action après l'ajout d'un vol
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Messages"),
// //       ),
// //       body: const Center(
// //         child: Text("Messages Page"),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: _showVolModal,
// //         child: const Icon(Icons.add),
// //       ),
// //     );
// //   }
// // }

// class MessagePage extends StatefulWidget {
//   const MessagePage({super.key});

//   @override
//   _MessagePageState createState() => _MessagePageState();
// }

// class _MessagePageState extends State<MessagePage> {
//   List<dynamic> pistes = [];
//   List<dynamic> vols = []; // Pour stocker les vols ajoutés

//   @override
//   void initState() {
//     super.initState();
//     _fetchPistes();
//     _fetchVols();
//   }

//   Future<void> _fetchPistes() async {
//     List<dynamic> fetchedPistes = await PisteService.getPistes();
//     setState(() {
//       pistes = fetchedPistes;
//     });
//   }

//   Future<void> _fetchVols() async {
//     List<dynamic> fetchedVols = await VolService.getVol();
//     setState(() {
//       vols = fetchedVols;
//     });
//   }

//   void _showVolModal() async {
//     final result = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(40),
//           ),
//           child: VolModal(pistes: pistes),
//         );
//       },
//     );

//     if (result != null) {
//       setState(() {
//         vols.add(result); // Ajouter le nouveau vol à la liste
//       });
//     }
//   }

//   // ############################## DELETING #################################//
//   Future<void> _confirmDeleteVol(String volId) async {
//     bool? confirmDelete = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Confirm Deletion'),
//           content: const Text('Are you sure you want to delete this vol?'),
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
//   }
//   // ############################## ENDING #################################//

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Messages"),
//       ),
//       // body: ListView.builder(
//       //   itemCount: vols.length,
//       //   itemBuilder: (context, index) {
//       //     final vol = vols[index];
//       //     final piste = pistes.firstWhere(
//       //         (piste) => piste['_id'] == vol['pisteAssignee'],
//       //         orElse: () => {'pisteName': 'Unknown'});
//       //     return ListTile(
//       //       title: Text(vol['numVol']),
//       //       subtitle: Text('Piste assignée: ${piste['pisteName']}'),
//       //     );
//       //   },
//       // ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//                 child: ListView.builder(
//                     itemCount: vols.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(vols[index]['compagnieAerienne']),
//                         subtitle: Text(vols[index]['status']),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: const Icon(Icons.edit),
//                               color:
//                                   Colors.blue, // Couleur de l'icône d'édition
//                               onPressed: () {},
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.delete),
//                               color: Colors
//                                   .red, // Couleur de l'icône de suppression
//                               onPressed: () {},
//                             ),
//                           ],
//                         ),
//                       );
//                     }))
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showVolModal,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:application/services/piste_service.dart'; // Assurez-vous que le chemin est correct
// import 'package:application/services/vol_service.dart'; // Assurez-vous que le chemin est correct
// import 'package:application/components/modal_vol/vol_modal.dart'; // Assurez-vous d'importer le fichier correctement

// class MessagePage extends StatefulWidget {
//   const MessagePage({super.key});

//   @override
//   _MessagePageState createState() => _MessagePageState();
// }

// class _MessagePageState extends State<MessagePage> {
//   List<dynamic> pistes = [];
//   List<dynamic> vols = []; // Pour stocker les vols ajoutés

//   @override
//   void initState() {
//     super.initState();
//     _fetchPistes();
//     _fetchVols();
//   }

//   Future<void> _fetchPistes() async {
//     List<dynamic> fetchedPistes = await PisteService.getPistes();
//     setState(() {
//       pistes = fetchedPistes;
//     });
//   }

//   Future<void> _fetchVols() async {
//     List<dynamic> fetchedVols = await VolService.getVol();
//     setState(() {
//       vols = fetchedVols;
//     });
//   }

//   void _showVolModal() async {
//     final result = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(40),
//           ),
//           child: VolModal(pistes: pistes),
//         );
//       },
//     );

//     if (result != null) {
//       setState(() {
//         vols.add(result); // Ajouter le nouveau vol à la liste
//       });
//     }
//   }

//   // ############################## DELETING #################################//
//   Future<void> _confirmDeleteVol(String volId) async {
//     bool? confirmDelete = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Confirm Deletion'),
//           content: const Text('Are you sure you want to delete this vol?'),
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
//   }
//   // ############################## ENDING #################################//

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Messages"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 3 / 2,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//           ),
//           itemCount: vols.length,
//           itemBuilder: (context, index) {
//             final vol = vols[index];
//             final piste = pistes.firstWhere(
//               (piste) => piste['_id'] == vol['pisteAssignee'],
//               orElse: () => {'pisteName': 'Unknown'},
//             );

//             return Card(
//               elevation: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Numéro de vol: ${vol['numVol']}',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text('Compagnie: ${vol['compagnieAerienne']}'),
//                     Text('Heure d\'arrivée: ${vol['heureArriveePrevue']}'),
//                     Text('Heure de départ: ${vol['heureDepartPrevue']}'),
//                     Text('Statut: ${vol['status']}'),
//                     Text('Piste: ${piste['pisteName']}'),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           color: Colors.blue,
//                           onPressed: () {},
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           color: Colors.red,
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showVolModal,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:application/services/piste_service.dart'; // Assurez-vous que le chemin est correct
// import 'package:application/services/vol_service.dart'; // Assurez-vous que le chemin est correct
// import 'package:application/components/modal_vol/vol_modal.dart'; // Assurez-vous d'importer le fichier correctement

// class MessagePage extends StatefulWidget {
//   const MessagePage({super.key});

//   @override
//   _MessagePageState createState() => _MessagePageState();
// }

// class _MessagePageState extends State<MessagePage> {
//   List<dynamic> pistes = [];
//   List<dynamic> vols = []; // Pour stocker les vols ajoutés

//   @override
//   void initState() {
//     super.initState();
//     _fetchPistes();
//     _fetchVols();
//   }

//   Future<void> _fetchPistes() async {
//     List<dynamic> fetchedPistes = await PisteService.getPistes();
//     setState(() {
//       pistes = fetchedPistes;
//     });
//   }

//   Future<void> _fetchVols() async {
//     List<dynamic> fetchedVols = await VolService.getVol();
//     setState(() {
//       vols = fetchedVols;
//     });
//   }

//   void _showVolModal() async {
//     final result = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(40),
//           ),
//           child: VolModal(pistes: pistes),
//         );
//       },
//     );

//     if (result != null) {
//       setState(() {
//         vols.add(result); // Ajouter le nouveau vol à la liste
//       });
//     }
//   }

//   // ############################## DELETING #################################//
//   Future<void> _confirmDeleteVol(String volId) async {
//     bool? confirmDelete = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Confirm Deletion'),
//           content: const Text('Are you sure you want to delete this vol?'),
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
//   }
//   // ############################## ENDING #################################//

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Messages"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 3 / 2,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//           ),
//           itemCount: vols.length,
//           itemBuilder: (context, index) {
//             final vol = vols[index];
//             final piste = pistes.firstWhere(
//               (piste) => piste['_id'] == vol['pisteAssignee'],
//               orElse: () => {'pisteName': 'Unknown'},
//             );

//             return Card(
//               elevation: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SingleChildScrollView( // Wrap the Column in a SingleChildScrollView
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Numéro de vol: ${vol['numVol']}',
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text('Compagnie: ${vol['compagnieAerienne']}'),
//                       Text('Heure d\'arrivée: ${vol['heureArriveePrevue']}'),
//                       Text('Heure de départ: ${vol['heureDepartPrevue']}'),
//                       Text('Statut: ${vol['status']}'),
//                       Text('Piste: ${piste['pisteName']}'),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.edit),
//                             color: Colors.blue,
//                             onPressed: () {},
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.delete),
//                             color: Colors.red,
//                             onPressed: () {},
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showVolModal,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }







// import 'package:flutter/material.dart';
// import 'package:application/services/piste_service.dart'; // Assurez-vous que le chemin est correct
// import 'package:application/services/vol_service.dart'; // Assurez-vous que le chemin est correct
// import 'package:application/components/modal_vol/vol_modal.dart'; // Assurez-vous d'importer le fichier correctement

// class MessagePage extends StatefulWidget {
//   const MessagePage({super.key});

//   @override
//   _MessagePageState createState() => _MessagePageState();
// }

// class _MessagePageState extends State<MessagePage> {
//   List<dynamic> pistes = [];
//   List<dynamic> vols = []; // Pour stocker les vols ajoutés

//   @override
//   void initState() {
//     super.initState();
//     _fetchPistes();
//     _fetchVols();
//   }

//   Future<void> _fetchPistes() async {
//     List<dynamic> fetchedPistes = await PisteService.getPistes();
//     setState(() {
//       pistes = fetchedPistes;
//     });
//   }

//   Future<void> _fetchVols() async {
//     List<dynamic> fetchedVols = await VolService.getVol();
//     setState(() {
//       vols = fetchedVols;
//     });
//   }

//   void _showVolModal() async {
//     final result = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(40),
//           ),
//           child: VolModal(pistes: pistes),
//         );
//       },
//     );

//     if (result != null) {
//       setState(() {
//         vols.add(result); // Ajouter le nouveau vol à la liste
//       });
//     }
//   }

//   // ############################## DELETING #################################//
//   Future<void> _confirmDeleteVol(String volId) async {
//     bool? confirmDelete = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Confirm Deletion'),
//           content: const Text('Are you sure you want to delete this vol?'),
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
//       // await VolService.deleteVol(volId); // Assurez-vous d'avoir une fonction pour supprimer le vol
//       _fetchVols(); // Recharger la liste des vols après suppression
//     }
//   }
//   // ############################## ENDING #################################//

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Messages"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView.builder(
//           itemCount: vols.length,
//           itemBuilder: (context, index) {
//             final vol = vols[index];
//             final piste = pistes.firstWhere(
//               (piste) => piste['_id'] == vol['pisteAssignee'],
//               orElse: () => {'pisteName': 'Unknown'},
//             );

//             return Card(
//               elevation: 4,
//               margin: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Numéro de vol: ${vol['numVol']}',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text('Compagnie: ${vol['compagnieAerienne']}'),
//                     Text('Heure d\'arrivée: ${vol['heureArriveePrevue']}'),
//                     Text('Heure de départ: ${vol['heureDepartPrevue']}'),
//                     Text('Statut: ${vol['status']}'),
//                     Text('Piste: ${piste['pisteName']}'),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           color: Colors.blue,
//                           onPressed: () {},
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           color: Colors.red,
//                           onPressed: () => _confirmDeleteVol(vol['_id']),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showVolModal,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }










// import 'package:flutter/material.dart';
// import 'package:application/services/piste_service.dart'; // Assurez-vous que le chemin est correct
// import 'package:application/services/vol_service.dart'; // Assurez-vous que le chemin est correct
// import 'package:application/components/modal_vol/vol_modal.dart'; // Assurez-vous d'importer le fichier correctement

// class MessagePage extends StatefulWidget {
//   const MessagePage({super.key});

//   @override
//   _MessagePageState createState() => _MessagePageState();
// }

// class _MessagePageState extends State<MessagePage> {
//   List<dynamic> pistes = [];
//   List<dynamic> vols = []; // Pour stocker les vols ajoutés

//   @override
//   void initState() {
//     super.initState();
//     _fetchPistes();
//     _fetchVols();
//   }

//   Future<void> _fetchPistes() async {
//     List<dynamic> fetchedPistes = await PisteService.getPistes();
//     setState(() {
//       pistes = fetchedPistes;
//     });
//   }

//   Future<void> _fetchVols() async {
//     List<dynamic> fetchedVols = await VolService.getVol();
//     setState(() {
//       vols = fetchedVols;
//     });
//   }

//   void _showVolModal() async {
//     final result = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(40),
//           ),
//           child: VolModal(pistes: pistes),
//         );
//       },
//     );

//     if (result != null) {
//       setState(() {
//         vols.add(result); // Ajouter le nouveau vol à la liste
//       });
//     }
//   }

//   // ############################## DELETING #################################//
//   Future<void> _confirmDeleteVol(String volId) async {
//     bool? confirmDelete = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Confirm Deletion'),
//           content: const Text('Are you sure you want to delete this vol?'),
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
//       // await VolService.deleteVol(volId); // Assurez-vous d'avoir une fonction pour supprimer le vol
//       _fetchVols(); // Recharger la liste des vols après suppression
//     }
//   }
//   // ############################## ENDING #################################//

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Messages"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView.builder(
//           itemCount: vols.length,
//           itemBuilder: (context, index) {
//             final vol = vols[index];
//             final piste = pistes.firstWhere(
//               (piste) => piste['_id'] == vol['pisteAssignee'],
//               orElse: () => null,
//             );

//             return Card(
//               elevation: 4,
//               margin: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Numéro de vol: ${vol['numVol']}',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text('Compagnie: ${vol['compagnieAerienne']}'),
//                     Text('Heure d\'arrivée: ${vol['heureArriveePrevue']}'),
//                     Text('Heure de départ: ${vol['heureDepartPrevue']}'),
//                     Text('Statut: ${vol['status']}'),
//                     Text('Piste: ${piste != null ? piste['pisteName'] : 'Unknown'}'),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           color: Colors.blue,
//                           onPressed: () {},
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           color: Colors.red,
//                           onPressed: () => _confirmDeleteVol(vol['_id']),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showVolModal,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }























// import 'package:flutter/material.dart';
// import 'package:application/services/piste_service.dart'; // Assurez-vous que le chemin est correct
// import 'package:application/services/vol_service.dart'; // Assurez-vous que le chemin est correct
// import 'package:application/components/modal_vol/vol_modal.dart'; // Assurez-vous d'importer le fichier correctement

// class MessagePage extends StatefulWidget {
//   const MessagePage({super.key});

//   @override
//   _MessagePageState createState() => _MessagePageState();
// }

// class _MessagePageState extends State<MessagePage> {
//   List<dynamic> pistes = [];
//   List<dynamic> vols = []; // Pour stocker les vols ajoutés

//   @override
//   void initState() {
//     super.initState();
//     _fetchPistes();
//     _fetchVols();
//   }

//   Future<void> _fetchPistes() async {
//     List<dynamic> fetchedPistes = await PisteService.getPistes();
//     setState(() {
//       pistes = fetchedPistes;
//     });
//   }

//   Future<void> _fetchVols() async {
//     List<dynamic> fetchedVols = await VolService.getVol();
//     setState(() {
//       vols = fetchedVols;
//     });
//   }

//   void _showVolModal() async {
//     final result = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(40),
//           ),
//           child: VolModal(pistes: pistes),
//         );
//       },
//     );

//     if (result == true) {
//       _fetchVols(); // Recharger la liste des vols après ajout
//     }
//   }

//   // ############################## DELETING #################################//
//   Future<void> _confirmDeleteVol(String volId) async {
//     bool? confirmDelete = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Confirm Deletion'),
//           content: const Text('Are you sure you want to delete this vol?'),
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
//       await VolService.deleteVol(volId); // Assurez-vous d'avoir une fonction pour supprimer le vol
//       _fetchVols(); // Recharger la liste des vols après suppression
//     }
//   }
//   // ############################## ENDING #################################//

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Messages"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView.builder(
//           itemCount: vols.length,
//           itemBuilder: (context, index) {
//             final vol = vols[index];
//             final piste = pistes.firstWhere(
//               (piste) => piste['_id'] == vol['pisteAssignee'],
//               orElse: () => null,
//             );

//             return Card(
//               elevation: 4,
//               margin: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Numéro de vol: ${vol['numVol']}',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text('Compagnie: ${vol['compagnieAerienne']}'),
//                     Text('Heure d\'arrivée: ${vol['heureArriveePrevue']}'),
//                     Text('Heure de départ: ${vol['heureDepartPrevue']}'),
//                     Text('Statut: ${vol['status']}'),
//                     Text('Piste: ${piste != null ? piste['pisteName'] : 'Unknown'}'),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           color: Colors.blue,
//                           onPressed: () {},
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           color: Colors.red,
//                           onPressed: () => _confirmDeleteVol(vol['_id']),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showVolModal,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }











import 'package:flutter/material.dart';
import 'package:application/services/piste_service.dart'; // Assurez-vous que le chemin est correct
import 'package:application/services/vol_service.dart'; // Assurez-vous que le chemin est correct
import 'package:application/components/modal_vol/vol_modal.dart'; // Assurez-vous d'importer le fichier correctement
import 'package:application/components/modal_vol/update_vol.dart'; // Assurez-vous d'importer le fichier correctement

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<dynamic> pistes = [];
  List<dynamic> vols = []; // Pour stocker les vols ajoutés

  @override
  void initState() {
    super.initState();
    _fetchPistes();
    _fetchVols();
  }

  Future<void> _fetchPistes() async {
    List<dynamic> fetchedPistes = await PisteService.getPistes();
    setState(() {
      pistes = fetchedPistes;
    });
  }

  Future<void> _fetchVols() async {
    List<dynamic> fetchedVols = await VolService.getVol();
    setState(() {
      vols = fetchedVols;
    });
  }

  void _showVolModal() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: VolModal(pistes: pistes),
        );
      },
    );

    if (result == true) {
      _fetchVols(); // Recharger la liste des vols après ajout
    }
  }

  void _showUpdateVolModal(String volId) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: UpdateVolModal(
            volId: volId,
            pistes: pistes,
          ),
        );
      },
    );

    if (result == true) {
      _fetchVols(); // Recharger la liste des vols après mise à jour
    }
  }

  // ############################## DELETING #################################//
  Future<void> _confirmDeleteVol(String volId) async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this vol?'),
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
      await VolService.deleteVol(volId); // Assurez-vous d'avoir une fonction pour supprimer le vol
      _fetchVols(); // Recharger la liste des vols après suppression
    }
  }
  // ############################## ENDING #################################//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messages"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: vols.length,
          itemBuilder: (context, index) {
            final vol = vols[index];
            final piste = pistes.firstWhere(
              (piste) => piste['_id'] == vol['pisteAssignee'],
              orElse: () => null,
            );

            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Numéro de vol: ${vol['numVol']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Compagnie: ${vol['compagnieAerienne']}'),
                    Text('Heure d\'arrivée: ${vol['heureArriveePrevue']}'),
                    Text('Heure de départ: ${vol['heureDepartPrevue']}'),
                    Text('Statut: ${vol['status']}'),
                    Text('Piste: ${piste != null ? piste['pisteName'] : 'Unknown'}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          color: Colors.blue,
                          onPressed: () => _showUpdateVolModal(vol['_id']),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () => _confirmDeleteVol(vol['_id']),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showVolModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
