import 'package:http/http.dart' as http;
import 'dart:convert';

class FocusService {
  final String _baseUrl = 'http://10.0.2.2:5000/api';

  Future<Map<String, dynamic>> saveFocusSession({
    required String? userId,
    required String startTime,
    required String endTime,
    required int duration,
    required int interruptions,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/focus-sessions'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "user_id": userId,
          "start_time": startTime,
          "end_time": endTime,
          "duration": duration,
          "interruptions": interruptions,
        }),
      );

      if (response.statusCode == 201) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to save session. Status: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Error connecting to server: $e',
      };
    }
  }

  Future<Map<String, dynamic>> fetchFocusSessions() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/focus-sessions'));

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': jsonDecode(response.body) as List<dynamic>,
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to load sessions. Status: \${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Error connecting to server: \$e',
      };
    }
  }
}
