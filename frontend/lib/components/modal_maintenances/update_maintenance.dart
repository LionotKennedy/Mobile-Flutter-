import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:application/services/maintenance_service.dart';

class UpdateMaintenanceModal extends StatefulWidget {
  final String maintId;
  final List<dynamic> pistes;

  const UpdateMaintenanceModal(
      {super.key, required this.maintId, required this.pistes});

  @override
  _UpdateMaintenanceModalState createState() => _UpdateMaintenanceModalState();
}

class _UpdateMaintenanceModalState extends State<UpdateMaintenanceModal> {
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _dateDebut;
  DateTime? _dateFin;
  String? selectedType;
  String? selectedPisteId;

  @override
  void initState() {
    super.initState();
    _fetchMaintenanceData();
  }

  Future<void> _fetchMaintenanceData() async {
    var maintenanceData =
        await MaintenanceService.getMaintenanceById(widget.maintId);
    print(widget.maintId);
    setState(() {
      _descriptionController.text = maintenanceData['description'] ?? '';
      _dateDebut = maintenanceData['dateDebut'] != null
          ? DateTime.parse(maintenanceData['dateDebut'])
          : null;
      _dateFin = maintenanceData['dateFin'] != null
          ? DateTime.parse(maintenanceData['dateFin'])
          : null;
      selectedType = maintenanceData['typeMaintenance'] ?? '';
      selectedPisteId = maintenanceData['pisteID'] ?? '';
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
              'Modifier un Vol',
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
                    : 'Heure d\'arrivée prévue : ${DateFormat('yyyy-MM-dd HH:mm').format(_dateDebut!)}',
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => _selectDateTime(context, false),
              child: Text(
                _dateFin == null
                    ? 'Sélectionner l\'heure de départ prévue'
                    : 'Heure de départ prévue : ${DateFormat('yyyy-MM-dd HH:mm').format(_dateFin!)}',
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
                labelText: 'Type de maintenance',
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
                    final dateDebut = _dateDebut?.toIso8601String();
                    final dateFin = _dateFin?.toIso8601String();
                    final typeMaintenance = selectedType;
                    final pisteID = selectedPisteId;
                    final description = _descriptionController.text;

                    if (description.isNotEmpty &&
                        dateDebut != null &&
                        dateFin != null &&
                        typeMaintenance != null &&
                        pisteID != null) {
                      final response =
                          await MaintenanceService.updateMaintenance(
                        widget.maintId,
                        pisteID,
                        typeMaintenance,
                        dateDebut,
                        dateFin,
                        description,
                      );
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
                      // print(widget.maintId);
                      // print(pisteID);
                      // print(typeMaintenance);
                      // print(dateDebut);
                      // print(dateFin);
                      // print(description);
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
