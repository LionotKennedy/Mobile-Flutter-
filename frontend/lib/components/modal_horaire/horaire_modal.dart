



import 'package:flutter/material.dart';
// import 'package:application/services/vol_service.dart'; // Assure-toi d'importer le service que tu vas créer
import 'package:intl/intl.dart'; // Assurez-vous d'importer la bibliothèque intl

class HoraireModal extends StatefulWidget {
  final List<dynamic> pistes;

  const HoraireModal({super.key, required this.pistes});

  @override
  _HoraireModalState createState() => _HoraireModalState();
}

class _HoraireModalState extends State<HoraireModal> {
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
              'Ajouter un Horaires',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            TextButton(
              onPressed: () => _selectDateTime(context, true),
              child: Text(
                _heureArriveePrevue == null
                    ? 'Sélectionner l\'heure d\'arrivée prévue'
                    // : 'Heure d\'arrivée prévue : ${_heureArriveePrevue.toString()}',
                    : 'Heure d\'arrivée prévue : ${DateFormat('yyyy-MM-dd HH:mm').format(_heureArriveePrevue!)}',
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => _selectDateTime(context, false),
              child: Text(
                _heureDepartPrevue == null
                    ? 'Sélectionner l\'heure de départ prévue'
                    // : 'Heure de départ prévue : ${_heureDepartPrevue.toString()}',
                    : 'Heure de départ prévue : ${DateFormat('yyyy-MM-dd HH:mm').format(_heureDepartPrevue!)}',
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

                    final heureArriveePrevue = _heureArriveePrevue?.toIso8601String();
                    final heureDepartPrevue = _heureDepartPrevue?.toIso8601String();
                    final status = selectedStatut;
                    final pisteAssignee = selectedPisteId;
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
