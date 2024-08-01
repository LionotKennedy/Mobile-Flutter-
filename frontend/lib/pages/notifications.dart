import 'package:flutter/material.dart';
import 'package:application/components/modal_notification/notification_modal.dart';
import 'package:application/components/modal_notification/update_notification.dart';
import 'package:application/services/notification_service.dart'; // Assure-toi d'importer le service que tu vas créer
import 'package:intl/intl.dart'; // Assurez-vous d'importer la bibliothèque intl

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  NotificationPageState createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationsPage> {
  List<dynamic> pistes = [];
  List<dynamic> notifications = [];

  @override
  void initState() {
    super.initState();
    // _fetchPistes();
    _fetchNotification();
  }

  // ############################## DELETING #################################//
  Future<void> _confirmDeleteNotification(String notiId) async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this vol?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Annuler la suppression
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirmer la suppression
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      _deleteNotification(notiId);
      print(notiId);
    }
  }

  Future<void> _deleteNotification(String notiId) async {
    final response = await NotificationService.deleteNotification(notiId);
    if (response['success']) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vol deleted successfully')),
      );
     _fetchNotification(); // Recharger la liste des vols après suppression
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    }
  }

  // ############################## ENDING #################################//

  // ##############################  FETCH DATA FROM DATABASE IN MAINTENANCES  #################################//
  Future<void> _fetchNotification() async {
    List<dynamic> fetchedNotifications =
        await NotificationService.getNotification();
    // print(fetchedMaintenances);
    setState(() {
      notifications = fetchedNotifications;
    });
  }
  // ############################## ENDING  #################################//

  // ############################## SHOW MODAL ADDING  #################################//
  void _showNotificationModal() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: const NotificationModal(),
        );
      },
    );

    if (result == true) {
        _fetchNotification();; // Recharger la liste des horaires après ajout
    }
  }
  // ############################## ENDING #################################//

  // ############################## SHOW MODAL UPDATING  #################################//
  void _showUpdateModal(String notiId) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: UpdateNotificationModal(
            notiId: notiId,
          ),
        );
      },
    );

    if (result == true) {
      _fetchNotification(); // Actualise la liste si une piste a été modifiée
    }
  }
  // ############################## ENDING #################################//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return ListTile(
                    title: Text(notifications[index]['type']),
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Message: ${notification['message']}\nDate et heur: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(notification['dateHeure']))}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          color: Colors.blue, // Couleur de l'icône d'édition
                          onPressed: () {
                            _showUpdateModal(notifications[index]['_id']);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          color:
                              Colors.red, // Couleur de l'icône de suppression
                          onPressed: () {
                            _confirmDeleteNotification(notifications[index]['_id']);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNotificationModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
