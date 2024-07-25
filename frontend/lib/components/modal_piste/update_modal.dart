// import 'package:flutter/material.dart';
// import 'package:application/services/piste_service.dart'; // Assurez-vous d'importer le service

// class UpdateModal extends StatefulWidget {
//   final String pisteId;

//   const UpdateModal({super.key, required this.pisteId});

//   @override
//   _UpdateModalState createState() => _UpdateModalState();
// }

// class _UpdateModalState extends State<UpdateModal> {
//   String? selectedOption;
//   final TextEditingController _pisteNameController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _fetchPisteData();
//   }

//   Future<void> _fetchPisteData() async {
//     var pisteData = await PisteService.getPisteById(widget.pisteId);
//     if (pisteData.isNotEmpty) {
//       setState(() {
//         _pisteNameController.text = pisteData['pisteName'];
//         selectedOption = pisteData['pisteStatus'];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.8, // Ajuste la largeur du modal
//         padding: const EdgeInsets.all(16.0),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(16)), // Réduit le rayon de la bordure pour un style plus moderne
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'Edit Piste',
//               textAlign: TextAlign.center, // Centre le titre
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextFormField(
//               controller: _pisteNameController,
//               decoration: const InputDecoration(
//                 labelText: 'Piste name',
//               ),
//             ),
//             const SizedBox(height: 20),
//             RadioListTile<String>(
//               title: const Text('Libre'),
//               value: 'libre',
//               groupValue: selectedOption,
//               onChanged: (String? value) {
//                 setState(() {
//                   selectedOption = value;
//                 });
//               },
//             ),
//             RadioListTile<String>(
//               title: const Text('Occupée'),
//               value: 'occupée',
//               groupValue: selectedOption,
//               onChanged: (String? value) {
//                 setState(() {
//                   selectedOption = value;
//                 });
//               },
//             ),
//             RadioListTile<String>(
//               title: const Text('En Maintenance'),
//               value: 'en maintenance',
//               groupValue: selectedOption,
//               onChanged: (String? value) {
//                 setState(() {
//                   selectedOption = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context, false); // Retourne false si annulé
//                   },
//                   child: const Text('Cancel'),
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
// import 'package:application/services/piste_service.dart'; // Assurez-vous d'importer le service

// class UpdateModal extends StatefulWidget {
//   final String pisteId;

//   const UpdateModal({super.key, required this.pisteId});

//   @override
//   _UpdateModalState createState() => _UpdateModalState();
// }

// class _UpdateModalState extends State<UpdateModal> {
//   String? selectedOption;
//   final TextEditingController _pisteNameController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _fetchPisteData();
//   }

//   Future<void> _fetchPisteData() async {
//     var pisteData = await PisteService.getPisteById(widget.pisteId);
//     if (pisteData.isNotEmpty) {
//       setState(() {
//         _pisteNameController.text = pisteData['pisteName'];
//         selectedOption = pisteData['pisteStatus'];
//       });
//       // Affiche les données dans la console
//       print('Données récupérées : $pisteData');
//     } else {
//       // Affiche un message d'erreur dans la console si les données ne sont pas récupérées
//       print('Aucune donnée trouvée pour l\'ID: ${widget.pisteId}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.8, // Ajuste la largeur du modal
//         padding: const EdgeInsets.all(16.0),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(16)), // Réduit le rayon de la bordure pour un style plus moderne
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'Edit Piste',
//               textAlign: TextAlign.center, // Centre le titre
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextFormField(
//               controller: _pisteNameController,
//               decoration: const InputDecoration(
//                 labelText: 'Piste name',
//               ),
//             ),
//             const SizedBox(height: 20),
//             RadioListTile<String>(
//               title: const Text('Libre'),
//               value: 'libre',
//               groupValue: selectedOption,
//               onChanged: (String? value) {
//                 setState(() {
//                   selectedOption = value;
//                 });
//               },
//             ),
//             RadioListTile<String>(
//               title: const Text('Occupée'),
//               value: 'occupée',
//               groupValue: selectedOption,
//               onChanged: (String? value) {
//                 setState(() {
//                   selectedOption = value;
//                 });
//               },
//             ),
//             RadioListTile<String>(
//               title: const Text('En Maintenance'),
//               value: 'en maintenance',
//               groupValue: selectedOption,
//               onChanged: (String? value) {
//                 setState(() {
//                   selectedOption = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context, false); // Retourne false si annulé
//                   },
//                   child: const Text('Cancel'),
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
// import 'package:application/services/piste_service.dart'; // Assurez-vous d'importer le service

// class UpdateModal extends StatefulWidget {
//   final String pisteId;

//   const UpdateModal({super.key, required this.pisteId});

//   @override
//   _UpdateModalState createState() => _UpdateModalState();
// }

// class _UpdateModalState extends State<UpdateModal> {
//   String? selectedOption;
//   final TextEditingController _pisteNameController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     print('initState called');
//     _fetchPisteData();
//   }

//   Future<void> _fetchPisteData() async {
//     print('Fetching data for pisteId: ${widget.pisteId}');
//     var pisteData = await PisteService.getPisteById(widget.pisteId);
//     print('Data fetched: $pisteData');
//     if (pisteData.isNotEmpty) {
//       setState(() {
//         _pisteNameController.text = pisteData['pisteName'];
//         selectedOption = pisteData['pisteStatus'];
//       });
//       // Affiche les données dans la console
//       print('Données récupérées : $pisteData');
//     } else {
//       // Affiche un message d'erreur dans la console si les données ne sont pas récupérées
//       print('Aucune donnée trouvée pour l\'ID: ${widget.pisteId}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.8, // Ajuste la largeur du modal
//         padding: const EdgeInsets.all(16.0),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(16)), // Réduit le rayon de la bordure pour un style plus moderne
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'Edit Piste',
//               textAlign: TextAlign.center, // Centre le titre
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextFormField(
//               controller: _pisteNameController,
//               decoration: const InputDecoration(
//                 labelText: 'Piste name',
//               ),
//             ),
//             const SizedBox(height: 20),
//             RadioListTile<String>(
//               title: const Text('Libre'),
//               value: 'libre',
//               groupValue: selectedOption,
//               onChanged: (String? value) {
//                 setState(() {
//                   selectedOption = value;
//                 });
//               },
//             ),
//             RadioListTile<String>(
//               title: const Text('Occupée'),
//               value: 'occupée',
//               groupValue: selectedOption,
//               onChanged: (String? value) {
//                 setState(() {
//                   selectedOption = value;
//                 });
//               },
//             ),
//             RadioListTile<String>(
//               title: const Text('En Maintenance'),
//               value: 'en maintenance',
//               groupValue: selectedOption,
//               onChanged: (String? value) {
//                 setState(() {
//                   selectedOption = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context, false); // Retourne false si annulé
//                   },
//                   child: const Text('Cancel'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }













import 'package:flutter/material.dart';
import 'package:application/services/piste_service.dart'; // Assurez-vous d'importer le service

class UpdateModal extends StatefulWidget {
  final String pisteId;

  const UpdateModal({super.key, required this.pisteId});

  @override
  _UpdateModalState createState() => _UpdateModalState();
}

class _UpdateModalState extends State<UpdateModal> {
  String? selectedOption;
  final TextEditingController _pisteNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('initState called');
    _fetchPisteData();
  }

  Future<void> _fetchPisteData() async {
    print('Fetching data for pisteId: ${widget.pisteId}');
    var pisteData = await PisteService.getPisteById(widget.pisteId);
    print('Data fetched: $pisteData');
    if (pisteData.isNotEmpty) {
      setState(() {
        _pisteNameController.text = pisteData['pisteName'];
        selectedOption = pisteData['pisteStatus'];
      });
      // Affiche les données dans la console
      print('Données récupérées : $pisteData');
    } else {
      // Affiche un message d'erreur dans la console si les données ne sont pas récupérées
      print('Aucune donnée trouvée pour l\'ID: ${widget.pisteId}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8, // Ajuste la largeur du modal
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)), // Réduit le rayon de la bordure pour un style plus moderne
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Edit Piste',
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

