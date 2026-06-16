import 'dart:convert';
import 'package:http/http.dart' as http; // 1. Import the package
import 'package:flutter_projects_getx/core/services/storage_services.dart';

class AuthService {
  final String baseUrl = "https://your-api-domain.com/api";
  
  // 2. You don't need a custom getter here. 
  // Simply use the 'http' alias imported above to make requests.

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Assuming your API returns {"token": "your_token_here"}
        await StorageService.saveToken(data['token']);
        return true;
      }
      return false;
    } catch (e) {
      // Handle network errors (e.g., no internet)
      print("Error during login: $e");
      return false;
    }
  }

  Future<void> logout() async {
    await StorageService.deleteToken();
  }
}