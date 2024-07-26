
// import 'package:flutter/material.dart';
// import 'package:application/services/vol_service.dart'; // Assure-toi d'importer le service que tu vas créer

// class VolModal extends StatefulWidget {
//   final List<dynamic> pistes;

//   const VolModal({super.key, required this.pistes});

//   @override
//   _VolModalState createState() => _VolModalState();
// }

// class _VolModalState extends State<VolModal> {
//   final TextEditingController _numeroVolController = TextEditingController();
//   final TextEditingController _compagnieController = TextEditingController();
//   DateTime? _heureArriveePrevue;
//   DateTime? _heureDepartPrevue;
//   String? selectedStatut;
//   String? selectedPisteId;

//   Future<void> _selectDateTime(BuildContext context, bool isArrival) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2101),
//     );

//     if (pickedDate != null) {
//       final TimeOfDay? pickedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//       );

//       if (pickedTime != null) {
//         setState(() {
//           if (isArrival) {
//             _heureArriveePrevue = DateTime(
//               pickedDate.year,
//               pickedDate.month,
//               pickedDate.day,
//               pickedTime.hour,
//               pickedTime.minute,
//             );
//           } else {
//             _heureDepartPrevue = DateTime(
//               pickedDate.year,
//               pickedDate.month,
//               pickedDate.day,
//               pickedTime.hour,
//               pickedTime.minute,
//             );
//           }
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: 500,
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
//               'Ajouter un Vol',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextFormField(
//               controller: _numeroVolController,
//               decoration: const InputDecoration(
//                 labelText: 'Numéro de vol',
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextFormField(
//               controller: _compagnieController,
//               decoration: const InputDecoration(
//                 labelText: 'Compagnie aérienne',
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextButton(
//               onPressed: () => _selectDateTime(context, true),
//               child: Text(
//                 _heureArriveePrevue == null
//                     ? 'Sélectionner l\'heure d\'arrivée prévue'
//                     : 'Heure d\'arrivée prévue : ${_heureArriveePrevue.toString()}',
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextButton(
//               onPressed: () => _selectDateTime(context, false),
//               child: Text(
//                 _heureDepartPrevue == null
//                     ? 'Sélectionner l\'heure de départ prévue'
//                     : 'Heure de départ prévue : ${_heureDepartPrevue.toString()}',
//               ),
//             ),
//             const SizedBox(height: 20),
//             DropdownButtonFormField<String>(
//               value: selectedStatut,
//               items: ['en vol', 'atterri', 'retardé', 'annulé']
//                   .map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedStatut = newValue;
//                 });
//               },
//               decoration: const InputDecoration(
//                 labelText: 'Statut',
//               ),
//             ),
//             const SizedBox(height: 20),
//             DropdownButtonFormField<String>(
//               value: selectedPisteId,
//               items:
//                   widget.pistes.map<DropdownMenuItem<String>>((dynamic piste) {
//                 return DropdownMenuItem<String>(
//                   value: piste['_id'],
//                   child: Text(piste['pisteName']),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedPisteId = newValue;
//                 });
//                 print(
//                     'Selected Piste ID: $newValue'); // Imprime l'ID de la piste sélectionnée
//               },
//               decoration: const InputDecoration(
//                 labelText: 'Piste assignée',
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context, false);
//                   },
//                   child: const Text('Cancel'),
//                 ),
//                 TextButton(
//                   onPressed: () async {
//                     final numVol = _numeroVolController.text;
//                     final compagnieAerienne = _compagnieController.text;
//                     final heureArriveePrevue =
//                         _heureArriveePrevue?.toIso8601String();
//                     final heureDepartPrevue =
//                         _heureDepartPrevue?.toIso8601String();
//                     final status = selectedStatut;
//                     final pisteAssignee = selectedPisteId;

//                     if (numVol.isNotEmpty &&
//                         compagnieAerienne.isNotEmpty &&
//                         heureArriveePrevue != null &&
//                         heureDepartPrevue != null &&
//                         status != null &&
//                         pisteAssignee != null) {
//                       final response = await VolService.createVol(
//                           numVol,
//                           compagnieAerienne,
//                           heureArriveePrevue,
//                           heureDepartPrevue,
//                           status,
//                           pisteAssignee);
//                       if (response['success']) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('Vol added successfully!')),
//                         );
//                         // Navigator.pop(context,
//                         //     true); // Retourne true si ajouté avec succès
//                         Navigator.pop(context, false);
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
//                   child: const Text('Save'),
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
import 'package:application/services/vol_service.dart'; // Assure-toi d'importer le service que tu vas créer

class VolModal extends StatefulWidget {
  final List<dynamic> pistes;

  const VolModal({super.key, required this.pistes});

  @override
  _VolModalState createState() => _VolModalState();
}

class _VolModalState extends State<VolModal> {
  final TextEditingController _numeroVolController = TextEditingController();
  final TextEditingController _compagnieController = TextEditingController();
  DateTime? _heureArriveePrevue;
  DateTime? _heureDepartPrevue;
  String? selectedStatut;
  String? selectedPisteId;

  Future<void> _selectDateTime(BuildContext context, bool isArrival) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          if (isArrival) {
            _heureArriveePrevue = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
          } else {
            _heureDepartPrevue = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Ajouter un Vol',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _numeroVolController,
              decoration: const InputDecoration(
                labelText: 'Numéro de vol',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _compagnieController,
              decoration: const InputDecoration(
                labelText: 'Compagnie aérienne',
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => _selectDateTime(context, true),
              child: Text(
                _heureArriveePrevue == null
                    ? 'Sélectionner l\'heure d\'arrivée prévue'
                    : 'Heure d\'arrivée prévue : ${_heureArriveePrevue.toString()}',
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => _selectDateTime(context, false),
              child: Text(
                _heureDepartPrevue == null
                    ? 'Sélectionner l\'heure de départ prévue'
                    : 'Heure de départ prévue : ${_heureDepartPrevue.toString()}',
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedStatut,
              items: ['en vol', 'atterri', 'retardé', 'annulé'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedStatut = newValue;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Statut',
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedPisteId,
              items: widget.pistes.map<DropdownMenuItem<String>>((dynamic piste) {
                return DropdownMenuItem<String>(
                  value: piste['_id'],
                  child: Text(piste['pisteName']),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedPisteId = newValue;
                });
                print('Selected Piste ID: $newValue'); // Imprime l'ID de la piste sélectionnée
              },
              decoration: const InputDecoration(
                labelText: 'Piste assignée',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    final numVol = _numeroVolController.text;
                    final compagnieAerienne = _compagnieController.text;
                    final heureArriveePrevue = _heureArriveePrevue?.toIso8601String();
                    final heureDepartPrevue = _heureDepartPrevue?.toIso8601String();
                    final status = selectedStatut;
                    final pisteAssignee = selectedPisteId;

                    if (numVol.isNotEmpty &&
                        compagnieAerienne.isNotEmpty &&
                        heureArriveePrevue != null &&
                        heureDepartPrevue != null &&
                        status != null &&
                        pisteAssignee != null) {
                      final response = await VolService.createVol(
                          numVol,
                          compagnieAerienne,
                          heureArriveePrevue,
                          heureDepartPrevue,
                          status,
                          pisteAssignee);
                      if (response['success']) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Vol added successfully!')),
                        );
                        Navigator.pop(context, true); // Retourne true si ajouté avec succès
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(response['message'])),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields')),
                      );
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
