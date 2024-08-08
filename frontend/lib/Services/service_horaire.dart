import 'package:http/http.dart' as http;
import 'dart:convert';

class HoraireService {
  // ############################## CREATING #################################//
  static Future<Map<String, dynamic>> createHoraire(
    String pisteID,
    String heureDebut,
    String heureFin,
    String volID,
  ) async {
    var url = Uri.parse('http://10.0.2.2:6789/time/createHoraire');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'pisteID': pisteID,
          'heureDebut': heureDebut,
          'heureFin': heureFin,
          'volID': volID,
        }),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Horaire ont été ajoutés avec succès ✅!!'};
      } else {
        return {'success': false, 'message': 'Failed to create horaire'};
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to connect to the server: $e'
      };
    }
  }
  // ############################## ENDING #################################//

  // ############################## GETTING #################################//
  static Future<List<dynamic>> getHoraire() async {
    var url = Uri.parse(
        'http://10.0.2.2:6789/time/readHoraire'); // Remplacez par l'URL correcte
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body)[
            'data']; // Assurez-vous que 'data' correspond à votre réponse
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching horaires: $e');
      return [];
    }
  }
  // ############################## ENDING #################################//

  // ############################## DELETING #################################//
  static Future<Map<String, dynamic>> deleteHoraire(String hourId) async {
    var url = Uri.parse('http://10.0.2.2:6789/time/deleteHoraire/$hourId');
    try {
      var response = await http.delete(url);
      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Horaire deleted successfully'};
      } else {
        return {'success': false, 'message': 'Failed to delete horaire'};
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to connect to the server: $e'
      };
    }
  }
  // ############################## ENDING #################################//

  // ############################## EDIING #################################//
  static Future<Map<String, dynamic>> getHoraireById(String hourId) async {
    var url = Uri.parse('http://10.0.2.2:6789/time/editHoraire/$hourId');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body)['data'];
      } else {
        throw Exception('Failed to load horaire');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
  // ############################## ENDING #################################//

  // ############################## UPDATING #################################//
  static Future<Map<String, dynamic>> updateHoraire(
    String hourId,
    String pisteID,
    String heureDebut,
    String heureFin,
    String volID,
  ) async {
    var url = Uri.parse('http://10.0.2.2:6789/time/updateHoraire/$hourId');
    try {
      var response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'pisteID': pisteID,
          'heureDebut': heureDebut,
          'heureFin': heureFin,
          'volID': volID,
        }),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Horaire updated successfully'};
      } else {
        return {'success': false, 'message': 'Failed to update horaire'};
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to connect to the server: $e'
      };
    }
  }
  // ############################## ENDING #################################//
}
