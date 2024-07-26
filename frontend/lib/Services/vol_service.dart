import 'package:http/http.dart' as http;
import 'dart:convert';

class VolService {
  static Future<Map<String, dynamic>> createVol(
    String numVol,
    String compagnieAerienne,
    String heureArriveePrevue,
    String heureDepartPrevue,
    String status,
    String pisteAssignee,
  ) async {
    var url = Uri.parse('http://10.0.2.2:6789/vol/createVol');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'numVol': numVol,
          'compagnieAerienne': compagnieAerienne,
          'heureArriveePrevue': heureArriveePrevue,
          'heureDepartPrevue': heureDepartPrevue,
          'status': status,
          'pisteAssignee': pisteAssignee
        }),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Vol created successfully'};
      } else {
        return {'success': false, 'message': 'Failed to create vol'};
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to connect to the server: $e'
      };
    }
  }

  static Future<List<dynamic>> getVol() async {
    var url = Uri.parse('http://10.0.2.2:6789/vol/readVol');
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

  // ############################## DELETING #################################//
  static Future<Map<String, dynamic>> deletePiste(String volId) async {
    var url = Uri.parse('http://10.0.2.2:6789/vol/deleteVol/volId');
    try {
      var response = await http.delete(url);
      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Vol deleted successfully'};
      } else {
        return {'success': false, 'message': 'Failed to delete Vol'};
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
