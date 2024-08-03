
import 'package:flutter/material.dart';
import 'package:application/services/piste_service.dart'; // Assure-toi d'importer le service que tu vas créer

class PisteModal extends StatefulWidget {
  const PisteModal({super.key});

  @override
  _PisteModalState createState() => _PisteModalState();
}

class _PisteModalState extends State<PisteModal> {
  String? selectedOption;
  final TextEditingController _pisteNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // width: MediaQuery.of(context).size.width *0.8, // Ajuste la largeur du modal
        width: MediaQuery.of(context).size.width * 0.7, // Réduire la largeur
        // height: MediaQuery.of(context).size.height * 0.8, // Ajuste la largeur du modal
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(
              16)), // Réduit le rayon de la bordure pour un style plus moderne
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Piste',
              textAlign: TextAlign.center, // Centre le titre
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _pisteNameController,
              decoration: const InputDecoration(
                labelText: 'Piste name',
              ),
            ),
            const SizedBox(height: 20),
            RadioListTile<String>(
              title: const Text('Libre'),
              value: 'libre',
              groupValue: selectedOption,
              onChanged: (String? value) {
                setState(() {
                  selectedOption = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Occupée'),
              value: 'occupée',
              groupValue: selectedOption,
              onChanged: (String? value) {
                setState(() {
                  selectedOption = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('En Maintenance'),
              value: 'en maintenance',
              groupValue: selectedOption,
              onChanged: (String? value) {
                setState(() {
                  selectedOption = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false); // Retourne false si annulé
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final pisteName = _pisteNameController.text;
                    final pisteStatus = selectedOption;

                    if (pisteName.isNotEmpty && pisteStatus != null) {
                      final response = await PisteService.createPiste(
                          pisteName, pisteStatus);
                      if (response['success']) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Piste added successfully!')),
                        );
                        Navigator.pop(context,
                            true); // Retourne true si ajouté avec succès
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(response['message'])),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: const Text('Please fill all fields')),
                      );
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


















// import 'package:flutter/material.dart';
// import 'package:application/services/piste_service.dart'; // Assure-toi d'importer le service que tu vas créer

// class PisteModal extends StatefulWidget {
//   const PisteModal({super.key});

//   @override
//   _PisteModalState createState() => _PisteModalState();
// }

// class _PisteModalState extends State<PisteModal> {
//   String? selectedOption;
//   final TextEditingController _pisteNameController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.5, // Réduire la largeur
//         padding: const EdgeInsets.all(16.0),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(16)),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'Add Piste',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 20, // Réduire la taille de la police
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10), // Réduire l'espacement
//             TextFormField(
//               controller: _pisteNameController,
//               decoration: const InputDecoration(
//                 labelText: 'Piste name',
//               ),
//             ),
//             const SizedBox(height: 10), // Réduire l'espacement
//             RadioListTile<String>(
//               title: const Text('Libre', style: TextStyle(fontSize: 10)), // Réduire la taille de la police
//               value: 'libre',
//               groupValue: selectedOption,
//               onChanged: (String? value) {
//                 setState(() {
//                   selectedOption = value;
//                 });
//               },
//             ),
//             RadioListTile<String>(
//               title: const Text('Occupée', style: TextStyle(fontSize: 10)), // Réduire la taille de la police
//               value: 'occupée',
//               groupValue: selectedOption,
//               onChanged: (String? value) {
//                 setState(() {
//                   selectedOption = value;
//                 });
//               },
//             ),
//             RadioListTile<String>(
//               title: const Text('En Maintenance', style: TextStyle(fontSize: 10)), // Réduire la taille de la police
//               value: 'en maintenance',
//               groupValue: selectedOption,
//               onChanged: (String? value) {
//                 setState(() {
//                   selectedOption = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 10), // Réduire l'espacement
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context, false); // Retourne false si annulé
//                   },
//                   child: const Text('Cancel'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     final pisteName = _pisteNameController.text;
//                     final pisteStatus = selectedOption;

//                     if (pisteName.isNotEmpty && pisteStatus != null) {
//                       final response = await PisteService.createPiste(pisteName, pisteStatus);
//                       if (response['success']) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('Piste added successfully!')),
//                         );
//                         Navigator.pop(context, true); // Retourne true si ajouté avec succès
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text(response['message'])),
//                         );
//                       }
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Please fill all fields')),
//                       );
//                     }
//                   },
//                   child: const Text('Add'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






















// import 'package:flutter/material.dart';
// import 'package:application/services/piste_service.dart'; // Assure-toi d'importer le service que tu vas créer

// class PisteModal extends StatefulWidget {
//   const PisteModal({super.key});

//   @override
//   _PisteModalState createState() => _PisteModalState();
// }

// class _PisteModalState extends State<PisteModal> {
//   String? selectedOption;
//   final TextEditingController _pisteNameController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.5, // Réduire la largeur
//         constraints: BoxConstraints(
//           maxHeight: MediaQuery.of(context).size.height * 0.6, // Limite la hauteur maximale
//         ),
//         padding: const EdgeInsets.all(16.0),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(16)),
//         ),
//         child: SingleChildScrollView( // Ajoute le défilement si nécessaire
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Add Piste',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 20, // Réduire la taille de la police
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10), // Réduire l'espacement
//               TextFormField(
//                 controller: _pisteNameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Piste name',
//                 ),
//               ),
//               const SizedBox(height: 10), // Réduire l'espacement
//               RadioListTile<String>(
//                 title: const Text('Libre', style: TextStyle(fontSize: 14)), // Réduire la taille de la police
//                 value: 'libre',
//                 groupValue: selectedOption,
//                 onChanged: (String? value) {
//                   setState(() {
//                     selectedOption = value;
//                   });
//                 },
//               ),
//               RadioListTile<String>(
//                 title: const Text('Occupée', style: TextStyle(fontSize: 14)), // Réduire la taille de la police
//                 value: 'occupée',
//                 groupValue: selectedOption,
//                 onChanged: (String? value) {
//                   setState(() {
//                     selectedOption = value;
//                   });
//                 },
//               ),
//               RadioListTile<String>(
//                 title: const Text('En Maintenance', style: TextStyle(fontSize: 14)), // Réduire la taille de la police
//                 value: 'en maintenance',
//                 groupValue: selectedOption,
//                 onChanged: (String? value) {
//                   setState(() {
//                     selectedOption = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 10), // Réduire l'espacement
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context, false); // Retourne false si annulé
//                     },
//                     child: const Text('Cancel'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       final pisteName = _pisteNameController.text;
//                       final pisteStatus = selectedOption;

//                       if (pisteName.isNotEmpty && pisteStatus != null) {
//                         final response = await PisteService.createPiste(pisteName, pisteStatus);
//                         if (response['success']) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Piste added successfully!')),
//                           );
//                           Navigator.pop(context, true); // Retourne true si ajouté avec succès
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text(response['message'])),
//                           );
//                         }
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('Please fill all fields')),
//                         );
//                       }
//                     },
//                     child: const Text('Add'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

















// import 'package:flutter/material.dart';
// import 'package:application/services/piste_service.dart'; // Assure-toi d'importer le service que tu vas créer

// class PisteModal extends StatefulWidget {
//   const PisteModal({super.key});

//   @override
//   _PisteModalState createState() => _PisteModalState();
// }

// class _PisteModalState extends State<PisteModal> {
//   String? selectedOption;
//   final TextEditingController _pisteNameController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.4, // Réduire encore la largeur
//         constraints: BoxConstraints(
//           maxHeight: MediaQuery.of(context).size.height * 0.4, // Réduire encore la hauteur maximale
//         ),
//         padding: const EdgeInsets.all(16.0),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(16)),
//         ),
//         child: SingleChildScrollView( // Ajoute le défilement si nécessaire
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Add Piste',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 20, // Taille de la police
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               TextFormField(
//                 controller: _pisteNameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Piste name',
//                 ),
//               ),
//               const SizedBox(height: 10),
//               RadioListTile<String>(
//                 title: const Text('Libre', style: TextStyle(fontSize: 14)),
//                 value: 'libre',
//                 groupValue: selectedOption,
//                 onChanged: (String? value) {
//                   setState(() {
//                     selectedOption = value;
//                   });
//                 },
//               ),
//               RadioListTile<String>(
//                 title: const Text('Occupée', style: TextStyle(fontSize: 14)),
//                 value: 'occupée',
//                 groupValue: selectedOption,
//                 onChanged: (String? value) {
//                   setState(() {
//                     selectedOption = value;
//                   });
//                 },
//               ),
//               RadioListTile<String>(
//                 title: const Text('En Maintenance', style: TextStyle(fontSize: 14)),
//                 value: 'en maintenance',
//                 groupValue: selectedOption,
//                 onChanged: (String? value) {
//                   setState(() {
//                     selectedOption = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context, false);
//                     },
//                     child: const Text('Cancel'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       final pisteName = _pisteNameController.text;
//                       final pisteStatus = selectedOption;

//                       if (pisteName.isNotEmpty && pisteStatus != null) {
//                         final response = await PisteService.createPiste(pisteName, pisteStatus);
//                         if (response['success']) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Piste added successfully!')),
//                           );
//                           Navigator.pop(context, true);
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text(response['message'])),
//                           );
//                         }
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('Please fill all fields')),
//                         );
//                       }
//                     },
//                     child: const Text('Add'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
