import 'package:flutter/material.dart';
import 'package:application/components/modal_maintenances/maintenance_modal.dart';
import 'package:application/components/modal_maintenances/update_maintenance.dart';
import 'package:application/services/piste_service.dart'; // Assurez-vous que le chemin est correct
import 'package:application/services/maintenance_service.dart'; // Assurez-vous que le chemin est correct
import 'package:intl/intl.dart'; // Assurez-vous d'importer la bibliothèque intl

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  PersonalPageState createState() => PersonalPageState();
}

class PersonalPageState extends State<PersonalPage> {
  List<dynamic> pistes = [];
  List<dynamic> maintenances = [];

  @override
  void initState() {
    super.initState();
    _fetchPistes();
    _fetchMaintenance();
  }

  // ############################## UPDATING #################################//
  void _showUpdateModal(String maintId) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: UpdateMaintenanceModal(
            maintId: maintId,
            pistes: pistes,
          ),
        );
      },
    );

    if (result == true) {
      _fetchMaintenance(); // Actualise la liste si une piste a été modifiée
    }
  }

  // ############################## ENDING #################################//

  // ##############################  FETCH DATA FROM DATABASE IN MAINTENANCES  #################################//
  Future<void> _fetchMaintenance() async {
    List<dynamic> fetchedMaintenances =
        await MaintenanceService.getMaintenance();
    // print(fetchedMaintenances);
    setState(() {
      maintenances = fetchedMaintenances;
    });
  }
  // ############################## ENDING  #################################//

  // ##############################  FETCH DATA FROM DATABASE IN PISTE  #################################//
  Future<void> _fetchPistes() async {
    List<dynamic> fetchedPistes = await PisteService.getPistes();
    // print(fetchedPistes);
    setState(() {
      pistes = fetchedPistes;
    });
  }
  // ############################## ENDING  #################################//

  // ##############################  FETCH DATA FROM DATABASE IN PISTE  #################################//
  String _getPisteName(String pisteID) {
    final piste = pistes.firstWhere(
      (piste) => piste['_id'] == pisteID,
      orElse: () => {'pisteName': 'Unknown Piste'},
    );
    return piste['pisteName'] ??
        'Unknown Piste'; // Assurez-vous que 'nom' est la clé correcte
  }
  // ############################## ENDING  #################################//

  // ############################## SHOW MODAL ADDING  #################################//
  void _showHoraireModal() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: MainteModal(pistes: pistes),
        );
      },
    );

    if (result == true) {
      _fetchMaintenance(); // Recharger la liste des horaires après ajout
    }
  }
  // ############################## ENDING #################################//


  // ############################## DELETING #################################//
  Future<void> _confirmDeleteMaintenance(String maintId) async {
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
      _deleteMaintenance(maintId);
      print(maintId);
    }
  }

  Future<void> _deleteMaintenance(String maintId) async {
    final response = await MaintenanceService.deleteMaintenance(maintId);
    if (response['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vol deleted successfully')),
      );
      _fetchMaintenance(); // Recharger la liste des vols après suppression
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    }
  }

  // ############################## ENDING #################################//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal"),
      ),
      body: Column(
        children: [
          // const Center(
          //   child: Text("Add Page Coucou"),
          // ),
          Expanded(
            child: maintenances.isEmpty
                ? const Center(child: Text("No horaires available"))
                : ListView.builder(
                    itemCount: maintenances.length,
                    itemBuilder: (context, index) {
                      final maintenance = maintenances[index];
                      return ListTile(
                        title: Text(
                            'Nom de la piste:  ${_getPisteName(maintenance['pisteID'])}'),
                        subtitle: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Type de maintenance: ${maintenance['typeMaintenance']}\nDescription: ${maintenance['description']}\nDate debut: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(maintenance['dateDebut']))}\nDate fin: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(maintenance['dateFin']))}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              color:
                                  Colors.blue, // Couleur de l'icône d'édition
                              onPressed: () {
                                _showUpdateModal(maintenances[index]['_id']);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors
                                  .red, // Couleur de l'icône de suppression
                              onPressed: () {
                                _confirmDeleteMaintenance(maintenances[index]['_id']);
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showHoraireModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
