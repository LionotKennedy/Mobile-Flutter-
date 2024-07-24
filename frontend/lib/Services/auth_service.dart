
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    var url = Uri.parse('http://10.0.2.2:6789/auth/login');
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        return {'success': true, 'user': responseBody['user'], 'token': responseBody['token']};
      } else {
        var responseBody = json.decode(response.body);
        return {'success': false, 'message': responseBody['message']};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to connect to the server'};
    }
  }

  Future<Map<String, dynamic>> logout(String email) async {
    var url = Uri.parse('http://10.0.2.2:6789/auth/logout');
    try {
      var response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Logged out successfully'};
      } else {
        var responseBody = json.decode(response.body);
        return {'success': false, 'message': responseBody['message']};
      }
    } catch (e) {
      return {'success': false, 'message': 'Failed to connect to the server'};
    }
  }
}
