import 'package:http/http.dart' as http;
import 'dart:convert';

class MaintenanceService {
  // ############################## CREATING #################################//
  static Future<Map<String, dynamic>> createMaintenance(
    String pisteID,
    String typeMaintenance,
    String dateDebut,
    String dateFin,
    String description,
  ) async {
    var url = Uri.parse('http://10.0.2.2:6789/settings/createMaint');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'pisteID': pisteID,
          'typeMaintenance': typeMaintenance,
          'dateDebut': dateDebut,
          'dateFin': dateFin,
          'description': description,
        }),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Maintenances created successfully'
        };
      } else {
        return {'success': false, 'message': 'Failed to create Maintenances'};
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
  static Future<List<dynamic>> getMaintenance() async {
    var url = Uri.parse(
        'http://10.0.2.2:6789/settings/readMaint'); // Remplacez par l'URL correcte
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
  static Future<Map<String, dynamic>> deleteMaintenance(String maintId) async {
    var url = Uri.parse('http://10.0.2.2:6789/settings/deleteMaint/$maintId');
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
  static Future<Map<String, dynamic>> getMaintenanceById(String maintId) async {
    var url = Uri.parse('http://10.0.2.2:6789/settings/editMaint/$maintId');
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
  static Future<Map<String, dynamic>> updateMaintenance(
      String maintId,
      String pisteID,
      String typeMaintenance,
      String dateDebut,
      String dateFin,
      String description) async {
    var url = Uri.parse('http://10.0.2.2:6789/settings/updateMaint/$maintId');
    try {
      var response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'pisteID': pisteID,
          'typeMaintenance': typeMaintenance,
          'dateDebut': dateDebut,
          'dateFin': dateFin,
          'description': description,
        }),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Maintenance updated successfully'};
      } else {
        return {'success': false, 'message': 'Failed to update Maintenance'};
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
