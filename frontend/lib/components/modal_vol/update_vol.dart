

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:application/services/vol_service.dart';

class UpdateVolModal extends StatefulWidget {
  final String volId;
  final List<dynamic> pistes;

  const UpdateVolModal({super.key, required this.volId, required this.pistes});

  @override
  // ignore: library_private_types_in_public_api
  _UpdateVolModalState createState() => _UpdateVolModalState();
}

class _UpdateVolModalState extends State<UpdateVolModal> {
  final TextEditingController _numeroVolController = TextEditingController();
  final TextEditingController _compagnieController = TextEditingController();
  DateTime? _heureArriveePrevue;
  DateTime? _heureDepartPrevue;
  String? selectedStatut;
  String? selectedPisteId;

  @override
  void initState() {
    super.initState();
    _fetchVolData();
  }

  Future<void> _fetchVolData() async {
    var volData = await VolService.getVolById(widget.volId);
    setState(() {
      _numeroVolController.text = volData['numVol'] ?? '';
      _compagnieController.text = volData['compagnieAerienne'] ?? '';
      _heureArriveePrevue = volData['heureArriveePrevue'] != null
          ? DateTime.parse(volData['heureArriveePrevue'])
          : null;
      _heureDepartPrevue = volData['heureDepartPrevue'] != null
          ? DateTime.parse(volData['heureDepartPrevue'])
          : null;
      selectedStatut = volData['status'] ?? '';
      selectedPisteId = volData['pisteAssignee'] ?? '';
    });
  }

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
              'Modifier un Vol',
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
                    : 'Heure d\'arrivée prévue : ${DateFormat('yyyy-MM-dd HH:mm').format(_heureArriveePrevue!)}',
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => _selectDateTime(context, false),
              child: Text(
                _heureDepartPrevue == null
                    ? 'Sélectionner l\'heure de départ prévue'
                    : 'Heure de départ prévue : ${DateFormat('yyyy-MM-dd HH:mm').format(_heureDepartPrevue!)}',
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedStatut,
              items: ['en vol', 'atterri', 'retardé', 'annulé']
                  .map((String value) {
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
                      final response = await VolService.updateVol(
                          widget.volId,
                          numVol,
                          compagnieAerienne,
                          heureArriveePrevue,
                          heureDepartPrevue,
                          status,
                          pisteAssignee);
                      if (response['success']) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Mis a jour effectier avec succes ✅!!')),
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context, true);
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

