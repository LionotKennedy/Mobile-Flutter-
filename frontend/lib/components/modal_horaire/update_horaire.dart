import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:application/services/service_horaire.dart';

class UpdateHoraireModal extends StatefulWidget {
  final String hourId;
  final List<dynamic> pistes;
  final List<dynamic> vols;

  const UpdateHoraireModal(
      {super.key,
      required this.hourId,
      required this.pistes,
      required this.vols});

  @override
  _UpdateHoraireModalState createState() => _UpdateHoraireModalState();
}

class _UpdateHoraireModalState extends State<UpdateHoraireModal> {
  DateTime? _heureDebut;
  DateTime? _heureFin;
  String? selectedVolId;
  String? selectedPisteId;

  @override
  void initState() {
    super.initState();
    _fetchVolData();
  }

  Future<void> _fetchVolData() async {
    var horaireData = await HoraireService.getHoraireById(widget.hourId);
    setState(() {
      _heureDebut = horaireData['heureDebut'] != null
          ? DateTime.parse(horaireData['heureDebut'])
          : null;
      _heureFin = horaireData['heureFin'] != null
          ? DateTime.parse(horaireData['heureFin'])
          : null;
      selectedVolId = horaireData['volID'] ?? '';
      selectedPisteId = horaireData['pisteID'] ?? '';
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
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          if (isArrival) {
           _heureDebut = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
          } else {
            _heureFin = DateTime(
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
            TextButton(
              onPressed: () => _selectDateTime(context, true),
              child: Text(
                _heureDebut == null
                    ? 'Sélectionner l\'heure d\'arrivée prévue'
                    : 'Heure d\'arrivée prévue : ${DateFormat('yyyy-MM-dd HH:mm').format(_heureDebut!)}',
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => _selectDateTime(context, false),
              child: Text(
                _heureFin == null
                    ? 'Sélectionner l\'heure de départ prévue'
                    : 'Heure de départ prévue : ${DateFormat('yyyy-MM-dd HH:mm').format(_heureFin!)}',
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedVolId,
              items: widget.vols.map<DropdownMenuItem<String>>((dynamic vol) {
                return DropdownMenuItem<String>(
                  value: vol['_id'],
                  child: Text(vol['numVol']),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedVolId = newValue;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Numero de vol',
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
                    final heureDebut = _heureDebut?.toIso8601String();
                    final heureFin = _heureFin?.toIso8601String();
                    final volID = selectedVolId;
                    final pisteID = selectedPisteId;

                    if (heureDebut != null &&
                        heureFin != null &&
                        volID != null &&
                        pisteID != null) {
                      final response = await HoraireService.updateHoraire(
                          widget.hourId,
                          pisteID,
                          heureDebut,
                          heureFin,
                          volID);
                      if (response['success']) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Vol updated successfully!')),
                        );
                        Navigator.pop(context, true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(response['message'])),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields')),
                      );
                      // print(heureDebut);
                      // print(heureFin);
                      // print(volID);
                      // print(pisteID);
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
