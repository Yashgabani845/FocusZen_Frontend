import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = 'http://10.0.2.2:5000/api/auth';
  
  // Simple static storage for the session (replaces SharedPreferences for now)
  static Map<String, dynamic>? currentUser;
  static String? token;

  Future<Map<String, dynamic>> login(String email, String password) async {
    return _sendRequest('/login', {
      'email': email,
      'password': password,
    });
  }

  Future<Map<String, dynamic>> signUp(String email, String username, String password) async {
    return _sendRequest('/signup', {
      'email': email,
      'username': username,
      'password': password,
    });
  }

  Future<Map<String, dynamic>> _sendRequest(String endpoint, Map<String, dynamic> body) async {
    try {
      final url = Uri.parse('$_baseUrl$endpoint');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        currentUser = responseBody['user'];
        token = responseBody['token'];
        return {'success': true, 'data': responseBody};
      } else {
        return {'success': false, 'error': responseBody['error'] ?? 'Authentication failed'};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error. Is the server running?'};
    }
  }
}
