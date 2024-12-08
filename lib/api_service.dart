import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://akithememegod.pythonanywhere.com"; // Replace with your Flask server URL

  // Add a student (POST request)
  Future<Map<String, dynamic>> addStudent(
    String rollno,
    String name,
    String email,
  ) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/api/add_student'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'rollno': rollno, 'name': name, 'email': email}),
        )
        .timeout(const Duration(seconds: 10)); // Timeout after 10 seconds

    if (response.statusCode == 201) {
      return json.decode(response.body); // Successfully added
    } else {
      throw Exception('Failed to add student: ${response.body}');
    }
  }

  // Mark attendance (POST request)
  Future<Map<String, dynamic>> markAttendance(
    String rollno,
    String subject,
  ) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/api/mark_attendance'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'rollno': rollno, 'subject': subject}),
        )
        .timeout(const Duration(seconds: 10)); // Timeout after 10 seconds

    if (response.statusCode == 200) {
      return json.decode(response.body); // Attendance marked
    } else {
      throw Exception('Failed to mark attendance: ${response.body}');
    }
  }

  // Fetch attendance (GET request)
  Future<List<dynamic>> fetchAttendance() async {
    final response = await http
        .get(Uri.parse('$baseUrl/api/fetch_attendance'))
        .timeout(const Duration(seconds: 10)); // Timeout after 10 seconds

    if (response.statusCode == 200) {
      return json.decode(response.body); // Parse attendance data
    } else {
      throw Exception('Failed to fetch attendance: ${response.body}');
    }
  }

  Future<List<String>> fetchrolls() async {
    final response = await http
        .get(Uri.parse('$baseUrl/api/rolls'))
        .timeout(const Duration(seconds: 10)); // Timeout after 10 seconds

    if (response.statusCode == 200) {
      // Parse and ensure the response is a List<String>
      List<dynamic> fetchedData = json.decode(response.body);
      return List<String>.from(
        fetchedData,
      ); // Convert dynamic list to List<String>
    } else {
      throw Exception('Failed to fetch roll numbers: ${response.body}');
    }
  }

  // Reset attendance (POST request)
  Future<Map<String, dynamic>> resetAttendance(
    String rollno,
    String subject,
  ) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/api/reset_attendance'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'rollno': rollno, 'subject': subject}),
        )
        .timeout(const Duration(seconds: 10)); // Timeout after 10 seconds

    if (response.statusCode == 200) {
      return json.decode(response.body); // Attendance reset
    } else {
      throw Exception('Failed to reset attendance: ${response.body}');
    }
  }

  // Mark only absent (POST request)
  Future<Map<String, dynamic>> markOnlyAbsent(
    List<String> rollNumbers, // This expects a List<String>
    String subject,
  ) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/api/mark_only_absent'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'roll': rollNumbers.join(
              ',',
            ), // Convert list back to comma-separated string for the API
            'subject': subject,
          }),
        )
        .timeout(const Duration(seconds: 10)); // Timeout after 10 seconds

    if (response.statusCode == 200) {
      return json.decode(response.body); // Attendance marked as absent
    } else {
      throw Exception('Failed to mark absent: ${response.body}');
    }
  }

  // Mark only present (POST request)
  Future<Map<String, dynamic>> markOnlyPresent(
    List<String> rollNumbers, // This expects a List<String>
    String subject,
  ) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/api/mark_only_present'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'roll': rollNumbers.join(
              ',',
            ), // Convert list back to comma-separated string for the API
            'subject': subject,
          }),
        )
        .timeout(const Duration(seconds: 10)); // Timeout after 10 seconds

    if (response.statusCode == 200) {
      return json.decode(response.body); // Attendance marked as present
    } else {
      throw Exception('Failed to mark present: ${response.body}');
    }
  }
}
