

import 'package:flutter/material.dart';
import 'package:application/services/piste_service.dart'; // Assurez-vous que le chemin est correct
import 'package:application/services/vol_service.dart'; // Assurez-vous que le chemin est correct
import 'package:application/components/modal_vol/vol_modal.dart'; // Assurez-vous d'importer le fichier correctement
import 'package:application/components/modal_vol/update_vol.dart'; // Assurez-vous d'importer le fichier correctement
import 'package:intl/intl.dart'; // Assurez-vous d'importer la bibliothèque intl

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<dynamic> pistes = [];
  List<dynamic> vols = []; // Pour stocker les vols ajoutés

  @override
  void initState() {
    super.initState();
    _fetchPistes();
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
    setState(() {
      vols = fetchedVols;
    });
  }

  void _showVolModal() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: VolModal(pistes: pistes),
        );
      },
    );

    if (result == true) {
      _fetchVols(); // Recharger la liste des vols après ajout
    }
  }

  void _showUpdateVolModal(String volId) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: UpdateVolModal(
            volId: volId,
            pistes: pistes,
          ),
        );
      },
    );

    if (result == true) {
      _fetchVols(); // Recharger la liste des vols après mise à jour
    }
  }

  // ############################## DELETING #################################//
  Future<void> _confirmDeleteVol(String volId) async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('⚠ Confirmation'),
          content: const Text('Êtes-vous sûr de vouloir supprimer?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Annuler la suppression
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirmer la suppression
              },
              child: const Text('Supprimer'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      _deleteVol(volId);
      // print(volId);
    }
  }

  Future<void> _deleteVol(String volId) async {
    final response = await VolService.deleteVol(volId);
    if (response['success']) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Suppression effectier avec succes ✅')),
      );
      _fetchVols(); // Recharger la liste des vols après suppression
    } else {
      // ignore: use_build_context_synchronously
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
        title: const Text("Liste du vol"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: vols.length,
          itemBuilder: (context, index) {
            final vol = vols[index];
            final piste = pistes.firstWhere(
              (piste) => piste['_id'] == vol['pisteAssignee'],
              orElse: () => null,
            );

            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Numéro de vol: ${vol['numVol']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Compagnie: ${vol['compagnieAerienne']}'),
                    Text('Heure d\'arrivée: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(vol['heureArriveePrevue']))}'),
                    Text('Heure de départ: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(vol['heureDepartPrevue']))}'),
                    Text('Statut: ${vol['status']}'),
                    Text('Piste: ${piste != null ? piste['pisteName'] : 'Unknown'}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          color: Colors.blue,
                          onPressed: () => _showUpdateVolModal(vol['_id']),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () => _confirmDeleteVol(vol['_id']),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showVolModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
