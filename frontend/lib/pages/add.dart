// import 'package:flutter/material.dart';
// import 'package:application/components/modal_horaire/horaire_modal.dart';
// import 'package:application/services/piste_service.dart'; // Assurez-vous que le chemin est correct

// class AddPage extends StatefulWidget {
//   const AddPage({super.key});

//   @override
//   AddPageState createState() => AddPageState();
// }

// class AddPageState extends State<AddPage> {
//   List<dynamic> pistes = [];
//   List<dynamic> heurs = []; // Pour stocker les vols ajoutés

//    @override
//   void initState() {
//     super.initState();
//     _fetchPistes();
//   }

//   Future<void> _fetchPistes() async {
//     List<dynamic> fetchedPistes = await PisteService.getPistes();
//     // print(pistes);
//     print(fetchedPistes);
//     setState(() {
//       pistes = fetchedPistes;
//     });
//   }

//   void _showVolModal() async {
//     final result = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(40),
//           ),
//           child: HoraireModal(pistes: pistes),
//         );
//       },
//     );

//     if (result == true) {
//       // _fetchVols(); // Recharger la liste des vols après ajout
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add"),
//       ),
//       body: const Center(
//         child: Text("Add Page Coucou"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showVolModal,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }












// import 'package:flutter/material.dart';
// import 'package:application/components/modal_horaire/horaire_modal.dart';
// import 'package:application/services/piste_service.dart'; // Assurez-vous que le chemin est correct
// import 'package:application/services/service_horaire.dart'; // Ajoutez l'import pour HoraireService

// class AddPage extends StatefulWidget {
//   const AddPage({super.key});

//   @override
//   AddPageState createState() => AddPageState();
// }

// class AddPageState extends State<AddPage> {
//   List<dynamic> pistes = [];
//   List<dynamic> horaires = []; // Pour stocker les horaires ajoutés

//   @override
//   void initState() {
//     super.initState();
//     _fetchPistes();
//     _fetchHoraires(); // Récupérer les horaires au démarrage
//   }

//   Future<void> _fetchPistes() async {
//     List<dynamic> fetchedPistes = await PisteService.getPistes();
//     setState(() {
//       pistes = fetchedPistes;
//     });
//   }


//   Future<void> _fetchHoraires() async {
//   List<dynamic> fetchedHoraires = await HoraireService.getHoraire();
//   print('Fetched horaires: $fetchedHoraires'); // Ajoutez ceci pour déboguer
//   setState(() {
//     horaires = fetchedHoraires;
//   });
// }

//   void _showHoraireModal() async {
//     final result = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(40),
//           ),
//           child: HoraireModal(pistes: pistes),
//         );
//       },
//     );

//     if (result == true) {
//       _fetchHoraires(); // Recharger la liste des horaires après ajout
//     }
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: const Text("Add"),
//   //     ),
//   //     body: Column(
//   //       children: [
//   //         const Center(
//   //           child: Text("Add Page Coucou"),
//   //         ),
//   //         Expanded(
//   //           child: ListView.builder(
//   //             itemCount: horaires.length,
//   //             itemBuilder: (context, index) {
//   //               final horaire = horaires[index];
//   //               return ListTile(
//   //                 title: Text('Piste: ${horaire['pisteID']}'),
//   //                 subtitle: Text('Heure Début: ${horaire['heureDebut']}\nHeure Fin: ${horaire['heureFin']}'),
//   //                 trailing: Text('Vol: ${horaire['volID']}'),
//   //               );
//   //             },
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //     floatingActionButton: FloatingActionButton(
//   //       onPressed: _showHoraireModal,
//   //       child: const Icon(Icons.add),
//   //     ),
//   //   );
//   // }


//   @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text("Add"),
//     ),
//     body: Column(
//       children: [
//         const Center(
//           child: Text("Add Page Coucou"),
//         ),
//         Expanded(
//           child: horaires.isEmpty
//               ? const Center(child: Text("No horaires available"))
//               : ListView.builder(
//                   itemCount: horaires.length,
//                   itemBuilder: (context, index) {
//                     final horaire = horaires[index];
//                     return ListTile(
//                       title: Text('Piste: ${horaire['pisteID']}'),
//                       subtitle: Text('Heure Début: ${horaire['heureDebut']}\nHeure Fin: ${horaire['heureFin']}'),
//                       trailing: Text('Vol: ${horaire['volID']}'),
//                     );
//                   },
//                 ),
//         ),
//       ],
//     ),
//     floatingActionButton: FloatingActionButton(
//       onPressed: _showHoraireModal,
//       child: const Icon(Icons.add),
//     ),
//   );
// }

// }







// import 'package:flutter/material.dart';
// import 'package:application/components/modal_horaire/horaire_modal.dart';
// import 'package:application/services/piste_service.dart'; // Assurez-vous que le chemin est correct
// import 'package:application/services/service_horaire.dart'; // Ajoutez l'import pour HoraireService

// class AddPage extends StatefulWidget {
//   const AddPage({super.key});

//   @override
//   AddPageState createState() => AddPageState();
// }

// class AddPageState extends State<AddPage> {
//   List<dynamic> pistes = [];
//   List<dynamic> horaires = []; // Pour stocker les horaires ajoutés

//   @override
//   void initState() {
//     super.initState();
//     _fetchPistes();
//     _fetchHoraires(); // Récupérer les horaires au démarrage
//   }

//   Future<void> _fetchPistes() async {
//     List<dynamic> fetchedPistes = await PisteService.getPistes();
//     setState(() {
//       pistes = fetchedPistes;
//     });
//   }

//   Future<void> _fetchHoraires() async {
//     List<dynamic> fetchedHoraires = await HoraireService.getHoraire();
//     print('Fetched horaires: $fetchedHoraires'); // Ajoutez ceci pour déboguer
//     setState(() {
//       horaires = fetchedHoraires;
//     });
//   }

//   String _getPisteName(String pisteID) {
//     final piste = pistes.firstWhere(
//       (piste) => piste['_id'] == pisteID,
//       orElse: () => {'nom': 'Unknown Piste'},
//     );
//     return piste['nom'] ?? 'Unknown Piste'; // Assurez-vous que 'nom' est la clé correcte
//   }

//   String _getVolNumber(String volID) {
//     // Ajoutez une liste ou méthode similaire pour obtenir les vols si vous ne l'avez pas
//     // Exemple :
//     // final vol = vols.firstWhere((vol) => vol['_id'] == volID, orElse: () => {'numeroVol': 'Unknown Vol'});
//     // return vol['numeroVol'] ?? 'Unknown Vol';

//     return 'Unknown Vol'; // Remplacez ceci par la logique pour obtenir le numéro de vol
//   }

//   void _showHoraireModal() async {
//     final result = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(40),
//           ),
//           child: HoraireModal(pistes: pistes),
//         );
//       },
//     );

//     if (result == true) {
//       _fetchHoraires(); // Recharger la liste des horaires après ajout
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add"),
//       ),
//       body: Column(
//         children: [
//           const Center(
//             child: Text("Add Page Coucou"),
//           ),
//           Expanded(
//             child: horaires.isEmpty
//                 ? const Center(child: Text("No horaires available"))
//                 : ListView.builder(
//                     itemCount: horaires.length,
//                     itemBuilder: (context, index) {
//                       final horaire = horaires[index];
//                       return ListTile(
//                         title: Text('Piste: ${_getPisteName(horaire['pisteID'])}'),
//                         subtitle: Text('Heure Début: ${horaire['heureDebut']}\nHeure Fin: ${horaire['heureFin']}'),
//                         trailing: Text('Vol: ${_getVolNumber(horaire['volID'])}'),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showHoraireModal,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }











import 'package:flutter/material.dart';
import 'package:application/components/modal_horaire/horaire_modal.dart';
import 'package:application/services/piste_service.dart';
import 'package:application/services/service_horaire.dart'; // Ajoutez l'import pour HoraireService

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  AddPageState createState() => AddPageState();
}

class AddPageState extends State<AddPage> {
  List<dynamic> pistes = [];
  List<dynamic> horaires = []; // Pour stocker les horaires ajoutés

  @override
  void initState() {
    super.initState();
    _fetchPistes();
    _fetchHoraires(); // Récupérer les horaires au démarrage
  }

  Future<void> _fetchPistes() async {
    List<dynamic> fetchedPistes = await PisteService.getPistes();
    setState(() {
      pistes = fetchedPistes;
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
      orElse: () => {'nom': 'Unknown Piste'},
    );
    return piste['nom'] ?? 'Unknown Piste'; // Assurez-vous que 'nom' est la clé correcte
  }

  String _getVolNumber(String volID) {
    return 'Unknown Vol'; // Remplacez ceci par la logique pour obtenir le numéro de vol
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
                        title: Text('Piste: ${_getPisteName(horaire['pisteID'])}'),
                        subtitle: Text('Heure Début: ${horaire['heureDebut']}\nHeure Fin: ${horaire['heureFin']}'),
                        trailing: Text('Vol: ${_getVolNumber(horaire['volID'])}'),
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
