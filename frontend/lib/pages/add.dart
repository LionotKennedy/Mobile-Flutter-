import 'package:flutter/material.dart';
import 'package:application/components/modal_horaire/horaire_modal.dart';
import 'package:application/components/modal_horaire/update_horaire.dart'; // Assurez-vous que le chemin est correct
import 'package:application/services/piste_service.dart'; // Assurez-vous que le chemin est correct
import 'package:application/services/vol_service.dart'; // Assurez-vous que le chemin est correct
import 'package:application/services/service_horaire.dart'; // Ajoutez l'import pour HoraireService
import 'package:intl/intl.dart'; // Assurez-vous d'importer la bibliothèque intl

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  AddPageState createState() => AddPageState();
}

class AddPageState extends State<AddPage> {
  List<dynamic> pistes = [];
  List<dynamic> vols = [];
  List<dynamic> horaires = []; // Pour stocker les horaires ajoutés

  @override
  void initState() {
    super.initState();
    _fetchPistes();
    _fetchHoraires(); // Récupérer les horaires au démarrage
    _fetchVols();
  }

  Future<void> _fetchPistes() async {
    List<dynamic> fetchedPistes = await PisteService.getPistes();
    // print(fetchedPistes);
    setState(() {
      pistes = fetchedPistes;
    });
  }

  Future<void> _fetchVols() async {
    List<dynamic> fetchedVols = await VolService.getVol();
    // print(fetchedPistes);
    setState(() {
      vols = fetchedVols;
    });
  }

  Future<void> _fetchHoraires() async {
    List<dynamic> fetchedHoraires = await HoraireService.getHoraire();
    print('Fetched horaires: $fetchedHoraires'); // Ajoutez ceci pour déboguer
    setState(() {
      horaires = fetchedHoraires;
    });
  }

  String _getPisteName(String pisteID) {
    final piste = pistes.firstWhere(
      (piste) => piste['_id'] == pisteID,
      orElse: () => {'pisteName': 'Unknown Piste'},
    );
    return piste['pisteName'] ??
        'Unknown Piste'; // Assurez-vous que 'nom' est la clé correcte
  }

  String _getVolNumber(String volID) {
    final vol = vols.firstWhere((vol) => vol['_id'] == volID,
        orElse: () => {'numVol': 'Unknown Vol'});
    return vol['numVol'] ?? 'Unknown Vol';
  }

  void _showHoraireModal() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: HoraireModal(pistes: pistes),
        );
      },
    );

    if (result == true) {
      _fetchHoraires(); // Recharger la liste des horaires après ajout
    }
  }

  // ############################## DELETING #################################//
  Future<void> _confirmDeleteHoraire(String hourId) async {
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
      _deleteHoraire(hourId);
      print(hourId);
    }
  }

  Future<void> _deleteHoraire(String hourId) async {
    final response = await HoraireService.deleteHoraire(hourId);
    if (response['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vol deleted successfully')),
      );
      _fetchHoraires(); // Recharger la liste des vols après suppression
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    }
  }

  // ############################## ENDING #################################//

  // ############################## UPDATING #################################//
  void _showUpdateModal(String hourId) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: UpdateHoraireModal(
            hourId: hourId,
            vols: vols,
            pistes: pistes,
          ),
        );
      },
    );

    if (result == true) {
      _fetchHoraires(); // Actualise la liste si une piste a été modifiée
    }
  }

  // ############################## ENDING #################################//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add"),
      ),
      body: Column(
        children: [
          const Center(
            child: Text("Add Page Coucou"),
          ),
          Expanded(
            child: horaires.isEmpty
                ? const Center(child: Text("No horaires available"))
                : ListView.builder(
                    itemCount: horaires.length,
                    itemBuilder: (context, index) {
                      final horaire = horaires[index];
                      return ListTile(
                        title: Text('Vol: ${_getVolNumber(horaire['volID'])}'),
                        subtitle: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Piste: ${_getPisteName(horaire['pisteID'])}\nHeure Début: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(horaire['heureDebut']))}\nHeure Fin: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(horaire['heureFin']))}\n'),
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
                                _showUpdateModal(horaires[index]['_id']);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors
                                  .red, // Couleur de l'icône de suppression
                              onPressed: () {
                                _confirmDeleteHoraire(horaires[index]['_id']);
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
