import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // MockAPI endpoint (as provided by the task)
  final String _baseUrl =
      'https://6a1f10beb79eec0d6cf07a62.mockapi.io/api/watch/watchUser';

  final _storage = const FlutterSecureStorage();

  // Keep token key consistent with StorageService/AuthCheckView
  static const _tokenKey = 'auth_token';

  Future<void> register({
    required String fullName,
    required String email,
    required String role,
    required String password,
  }) async {

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'fullName': fullName,
        'email': email,
        'role': role,
        'password': password,
      }),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed to register');
    }

    // MockAPI usually returns the created user object.
    // Store something non-empty so AuthCheckView can consider user logged in.
    final body = jsonDecode(response.body);
    final token = body is Map && (body['token'] != null)
        ? body['token'].toString()
        : (body['id'] != null ? body['id'].toString() : email);

    // Persist profile fields so the Profile screen can show the signup inputs
    await _storage.write(key: 'user_name', value: fullName);
    await _storage.write(key: 'user_email', value: email);

    await _storage.write(key: _tokenKey, value: token);
  }

  /// Login by reading all users from the mock endpoint and matching locally.

  /// - If email exists but password mismatches -> throw "Invalid password"
  /// - If email not found -> throw "User not found"
  Future<void> login({
    required String email,
    required String password,
  }) async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode != 200) {
      throw Exception('Login failed');
    }

    final data = jsonDecode(response.body);
    if (data is! List) {
      throw Exception('Unexpected API response');
    }

    final matches = data.where((u) {
      if (u is! Map) return false;
      final uEmail = u['email']?.toString().toLowerCase();
      return uEmail == email.toLowerCase();
    }).toList();

    // If the API returns the user, capture name/email for profile screen.

    if (matches.isEmpty) {
      throw Exception('User not found');
    }

    final user = matches.first;
    final uPassword = user['password']?.toString();

    if (uPassword != password) {
      throw Exception('Invalid password');
    }

    final token = user['token']?.toString() ?? user['id']?.toString() ?? email;

    // Persist profile fields so Profile screen can show correct name/email
    final fullName = user['fullName']?.toString() ?? user['name']?.toString();
    final userEmail = user['email']?.toString();

    // If fullName field is missing, try common keys.
    final resolvedName = (fullName != null && fullName.isNotEmpty)
        ? fullName
        : (user['fullName']?.toString().isNotEmpty == true
            ? user['fullName']?.toString()
            : (user['name']?.toString().isNotEmpty == true
                ? user['name']?.toString()
                : null));

    if (resolvedName != null && resolvedName.isNotEmpty) {
      await _storage.write(key: 'user_name', value: resolvedName);
    }

    if (userEmail != null && userEmail.isNotEmpty) {
      await _storage.write(key: 'user_email', value: userEmail);
    } else {
      // fallback to the email used for login
      await _storage.write(key: 'user_email', value: email);
    }


    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async => await _storage.read(key: _tokenKey);
}
