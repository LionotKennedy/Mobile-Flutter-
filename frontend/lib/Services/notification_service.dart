import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationService {
  static Future<Map<String, dynamic>> createNotification(
      String type, String message, String dateHeure) async {
    var url = Uri.parse('http://10.0.2.2:6789/notification/createNotif');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'type': type,
          'message': message,
          'dateHeure': dateHeure,
        }),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Notification created successfully'
        };
      } else {
        return {'success': false, 'message': 'Failed to create notification'};
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Failed to connect to the server: $e'
      };
    }
  }

  static Future<List<dynamic>> getNotification() async {
    var url = Uri.parse('http://10.0.2.2:6789/notification/readNotif');
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

  static Future<Map<String, dynamic>> deleteNotification(String notiId) async {
    var url =
        Uri.parse('http://10.0.2.2:6789/notification/deleteNotif/$notiId');
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

  static Future<Map<String, dynamic>> getNotificationById(String notiId) async {
    var url = Uri.parse('http://10.0.2.2:6789/notification/editNotif/$notiId');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['data'];
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

  static Future<Map<String, dynamic>> updateNotification(
      String notiId, String type, String message, String dateHeure) async {
    var url =
        Uri.parse('http://10.0.2.2:6789/notification/updateNotif/$notiId');
    try {
      var response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'type': type,
          'message': message,
          'dateHeure': dateHeure,
        }),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Notification updated successfully'
        };
      } else {
        return {'success': false, 'message': 'Failed to updated Notification'};
      }
      // else {
      //   return {
      //     'success': false,
      //     'message': 'Failed to update Notification',
      //     'type': type,
      //     'message': message,
      //     'dateHeure': dateHeure,
      //   };
      // }

      // else {
      //   return {
      //     'success': false,
      //     'message': 'Failed to update Notification',
      //     'type': type,
      //     'message': message,
      //     'dateHeure': dateHeure,
      //   };
      // }
    } catch (e) {
      return {};
    }
  }
}
