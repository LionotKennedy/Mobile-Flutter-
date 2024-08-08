

import 'package:flutter/material.dart';
import 'package:application/services/piste_service.dart'; // Assurez-vous d'importer le service

class UpdateModal extends StatefulWidget {
  final String pisteId;

  const UpdateModal({super.key, required this.pisteId});

  @override
  // ignore: library_private_types_in_public_api
  _UpdateModalState createState() => _UpdateModalState();
}

class _UpdateModalState extends State<UpdateModal> {
  String? selectedOption;
  final TextEditingController _pisteNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPisteData();
  }

  Future<void> _fetchPisteData() async {
    var pisteData = await PisteService.getPisteById(widget.pisteId);
    if (pisteData.isNotEmpty) {
      setState(() {
        _pisteNameController.text = pisteData['pisteName'];
        selectedOption = pisteData['pisteStatus'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500, // Fixe la largeur à 500 pixels
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
              'Modification du Piste',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _pisteNameController,
              decoration: const InputDecoration(
                labelText: 'Nom du piste',
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
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () async {
                    final pisteName = _pisteNameController.text;
                    final pisteStatus = selectedOption;

                    if (pisteName.isNotEmpty && pisteStatus != null) {
                      final response = await PisteService.updatePiste(
                          pisteName, pisteStatus, widget.pisteId);
                      if (response['success']) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Mis a jour effectier avec succes ✅!')),
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context, true); // Retourne true si ajouté avec succès
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(response['message'])),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields ❌')),
                      );
                    }
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
