import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String _baseUrl = 'http://10.0.2.2:5000/api/auth'; // 10.0.2.2 is the Android emulator's local host
  final _storage = const FlutterSecureStorage();

  Future<void> register(String fullName, String email, String role, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'fullName': fullName, 'email': email, 'role': role, 'password': password}),
    );
    if (response.statusCode != 201) throw Exception('Failed to register');
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      await _storage.write(key: 'jwt', value: token); // Store JWT securely
    } else {
      throw Exception('Login failed');
    }
  }

  Future<String?> getToken() async => await _storage.read(key: 'jwt');
}