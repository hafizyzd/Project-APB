import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://your-laravel-api-url/api';

  Future<void> signUp(String name, String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nama_lengkap': name,
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      // Successfully signed up
    } else {
      // Handle error
      throw Exception('Failed to sign up: ${response.body}');
    }
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully logged in
    } else {
      // Handle error
      throw Exception('Failed to login: ${response.body}');
    }
  }
}
