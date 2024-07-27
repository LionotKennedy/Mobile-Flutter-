import 'package:flutter/material.dart';
import 'package:application/components/modal_horaire/horaire_modal.dart';
import 'package:application/services/piste_service.dart'; // Assurez-vous que le chemin est correct

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  AddPageState createState() => AddPageState();
}

class AddPageState extends State<AddPage> {
  List<dynamic> pistes = [];
  List<dynamic> heurs = []; // Pour stocker les vols ajoutés

   @override
  void initState() {
    super.initState();
    _fetchPistes();
  }

  Future<void> _fetchPistes() async {
    List<dynamic> fetchedPistes = await PisteService.getPistes();
    // print(pistes);
    print(fetchedPistes);
    setState(() {
      pistes = fetchedPistes;
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
          child: HoraireModal(pistes: pistes),
        );
      },
    );

    if (result == true) {
      // _fetchVols(); // Recharger la liste des vols après ajout
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add"),
      ),
      body: const Center(
        child: Text("Add Page Coucou"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showVolModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
