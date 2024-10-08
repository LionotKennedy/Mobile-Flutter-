
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
              'Ajout du Piste',
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
                labelText: 'Nom su piste',
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
                ElevatedButton(
                  onPressed: () async {
                    final pisteName = _pisteNameController.text;
                    final pisteStatus = selectedOption;

                    if (pisteName.isNotEmpty && pisteStatus != null) {
                      final response = await PisteService.createPiste(
                          pisteName, pisteStatus);
                      if (response['success']) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Piste ont été ajoutés avec succès ✅!')),
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
