import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:application/services/notification_service.dart';

class UpdateNotificationModal extends StatefulWidget {
  final String notiId;

  const UpdateNotificationModal({super.key, required this.notiId});

  @override
  // ignore: library_private_types_in_public_api
  _UpdateNotificationModalState createState() =>
      _UpdateNotificationModalState();
}

class _UpdateNotificationModalState extends State<UpdateNotificationModal> {
  final TextEditingController _messageController = TextEditingController();
  DateTime? _dateHeure;
  String? selectedType;

  @override
  void initState() {
    super.initState();
    _fetchMaintenanceData();
  }

  Future<void> _fetchMaintenanceData() async {
    var maintenanceData =
        await NotificationService.getNotificationById(widget.notiId);
    print(widget.notiId);
    setState(() {
      _messageController.text = maintenanceData['message'] ?? '';
      _dateHeure = maintenanceData['dateHeure'] != null
          ? DateTime.parse(maintenanceData['dateHeure'])
          : null;
      selectedType = maintenanceData['type'] ?? '';
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
            _dateHeure = DateTime(
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
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Description de maintenance',
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => _selectDateTime(context, true),
              child: Text(
                _dateHeure == null
                    ? 'Sélectionner l\'heure d\'arrivée prévue'
                    : 'Heure d\'arrivée prévue : ${DateFormat('yyyy-MM-dd HH:mm').format(_dateHeure!)}',
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedType,
              items: ['retard', 'urgence', 'maintenance'].map((String value) {
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
                labelText: 'Type de message',
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
                    final dateHeure = _dateHeure?.toIso8601String();

                    final type = selectedType;

                    final message = _messageController.text;

                    if (message.isNotEmpty &&
                        dateHeure != null &&
                        type != null) {
                      final response =
                          await NotificationService.updateNotification(
                        widget.notiId,
                        type,
                        message,
                        dateHeure,
                      );
                        print(widget.notiId);
                        print(type);
                        print(message);
                        print(dateHeure);
                      if (response['success']) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Vol updated successfully!')),
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
