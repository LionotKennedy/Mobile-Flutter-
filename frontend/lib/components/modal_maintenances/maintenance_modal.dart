import 'package:flutter/material.dart';
import 'package:application/services/maintenance_service.dart'; // Assure-toi d'importer le service que tu vas créer
import 'package:intl/intl.dart'; // Assurez-vous d'importer la bibliothèque intl

class MainteModal extends StatefulWidget {
  final List<dynamic> pistes;

  const MainteModal({super.key, required this.pistes});

  @override
  // ignore: library_private_types_in_public_api
  _MainteModalState createState() => _MainteModalState();
}

class _MainteModalState extends State<MainteModal> {
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _dateDebut;
  DateTime? _dateFin;
  String? selectedType;
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
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          if (isArrival) {
            _dateDebut = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
          } else {
            _dateFin = DateTime(
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
              'Ajouter un Maintenance',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description de maintenance',
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => _selectDateTime(context, true),
              child: Text(
                _dateDebut == null
                    ? 'Sélectionner l\'heure d\'arrivée prévue'
                    // : 'Heure d\'arrivée prévue : ${_heureArriveePrevue.toString()}',
                    : 'Date debut prévue : ${DateFormat('yyyy-MM-dd HH:mm').format(_dateDebut!)}',
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => _selectDateTime(context, false),
              child: Text(
                _dateFin == null
                    ? 'Sélectionner l\'heure de départ prévue'
                    // : 'Heure de départ prévue : ${_heureDepartPrevue.toString()}',
                    : 'Date fin prévue : ${DateFormat('yyyy-MM-dd HH:mm').format(_dateFin!)}',
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedType,
              items: ['programmée', 'urgence'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedType = newValue;
                });
              },
              decoration: const InputDecoration(
                labelText: 'TypeMaintenance',
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedPisteId,
              items:
                  widget.pistes.map<DropdownMenuItem<String>>((dynamic piste) {
                return DropdownMenuItem<String>(
                  value: piste['_id'],
                  child: Text(piste['pisteName']),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedPisteId = newValue;
                });
                // print('Selected Piste ID: $newValue'); // Imprime l'ID de la piste sélectionnée
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
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () async {
                    final description = _descriptionController.text;
                    final dateDebut = _dateDebut?.toIso8601String();
                    final dateFin = _dateFin?.toIso8601String();
                    final typeMaintenance = selectedType;
                    final pisteID = selectedPisteId;

                    if (description.isNotEmpty &&
                        dateDebut != null &&
                        dateFin != null &&
                        typeMaintenance != null &&
                        pisteID != null) {
                      final response = await MaintenanceService.createMaintenance(
                          pisteID,
                          typeMaintenance,
                          dateDebut,
                          dateFin,
                          description,
                          );
                      if (response['success']) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Maintenances ont été ajoutés avec succès ✅!!')),
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context,
                            true); // Retourne true si ajouté avec succès
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(response['message'])),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Les champs obligatoirement remplir ❌')),
                      );
                    }
                      // print(description);
                      // print(dateDebut);
                      // print(dateFin);
                      // print(typeMaintenance);
                      // print(pisteID);
                  },
                  child: const Text('Enregistrer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
