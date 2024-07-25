import 'package:http/http.dart' as http;
import 'dart:convert';

class PisteService {
  static Future<Map<String, dynamic>> createPiste(
      String pisteName, String pisteStatus) async {
    var url = Uri.parse('http://10.0.2.2:6789/piste/createPiste');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'pisteName': pisteName, 'pisteStatus': pisteStatus}),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Piste created successfully'};
      } else {
        return {'success': false, 'message': 'Failed to create piste'};
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to connect to the server: $e'
      };
    }
  }

  static Future<List<dynamic>> getPistes() async {
    var url = Uri.parse('http://10.0.2.2:6789/piste/readPiste');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body)['data'];
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<Map<String, dynamic>> deletePiste(String pisteId) async {
    var url = Uri.parse('http://10.0.2.2:6789/piste/deletePiste/$pisteId');
    try {
      var response = await http.delete(url);
      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Piste deleted successfully'};
      } else {
        return {'success': false, 'message': 'Failed to delete piste'};
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to connect to the server: $e'
      };
    }
  }

  static Future<Map<String, dynamic>> getPisteById(String pisteId) async {
    var url = Uri.parse('http://10.0.2.2:6789/piste/editPiste/$pisteId');
    // print('URL: $url'); // Affichage de l'URL
    // print('Bonjour...'); // Affichage de l'URL
    try {
      var response = await http.get(url);
      // print('Response status: ${response.statusCode}'); // Affichage du statut de la réponse
      // print('Response body: ${response.body}'); // Affichage du corps de la réponse
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['data'];
        // print('Données brutes récupérées : $data'); // Affichage des données brutes
        return data;
      } else {
        // print('Erreur ${response.statusCode} lors de la récupération des données');
        return {};
      }
    } catch (e) {
      // print('Erreur lors de la connexion au serveur : $e');
      return {};
    }
  }

  static Future<Map<String, dynamic>> updatePiste(
      String pisteName, String pisteStatus, String pisteId) async {
    var url = Uri.parse('http://10.0.2.2:6789/piste/updatePiste/$pisteId');
    try {
      var response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'pisteName': pisteName, 'pisteStatus': pisteStatus}),
      );
      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Piste created successfully'};
      } else {
        return {'success': false, 'message': 'Failed to create piste'};
      }
    } catch (e) {
      return {};
    }
  }

  // static Future<Map<String, dynamic>> updatePiste(String pisteName, String pisteStatus, String pisteId) async {
  //   var url = Uri.parse('http://10.0.2.2:6789/piste/editPiste/$pisteId');
  // }
}
