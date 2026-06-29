import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

/// Phone auth based on the same MockAPI data source used in [AuthService].
///
/// Expected behavior for this project:
/// - phone "register": send OTP (mock) and navigate to OTP screen
/// - phone "login": verify OTP (mock) and store a token so AuthCheckView
///   redirects to /home.
///
/// Notes:
/// - This project does NOT have a dedicated phone endpoint.
/// - We match by phoneNumber against user objects in MockAPI.
class PhoneAuthService {
  // Same endpoint style as AuthService
  final String _baseUrl =
      'https://6a1f10beb79eec0d6cf07a62.mockapi.io/api/watch/watchUser';

  final _storage = const FlutterSecureStorage();

  static const _tokenKey = 'auth_token';

  /// Mock send OTP.
  /// For a real API, you would call your backend here.
  Future<void> sendOtp({
    required String phoneNumber,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required void Function(String errorMessage) onError,
  }) async {
    // Basic validation
    if (phoneNumber.trim().isEmpty) {
      onError('Phone number is required');
      return;
    }

    // In this mock: create a fake verificationId
    final verificationId = 'mock_verification_${phoneNumber.trim()}';
    onCodeSent(verificationId, null);
  }

  /// Verify OTP (mock) and login user by phone.
  /// On success, store auth token.
  Future<void> verifyOtpAndLogin({
    required String phoneNumber,
    required String smsCode,
    // kept to show where verificationId would be used if needed
    String? verificationId,
  }) async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode != 200) {
      throw Exception('Phone login failed');
    }

    final data = jsonDecode(response.body);
    if (data is! List) {
      throw Exception('Unexpected API response');
    }

    final matches = data.where((u) {
      if (u is! Map) return false;
      final uPhone = u['phone']?.toString();
      if (uPhone == null) return false;
      return uPhone.replaceAll(' ', '') == phoneNumber.trim().replaceAll(' ', '');
    }).toList();

    // OTP must be 4 digits in this mock
    if (smsCode.trim().length != 4) {
      throw Exception('Invalid OTP');
    }

    if (matches.isEmpty) {
      // If your mock API doesn't have phone fields yet, fallback:
      // allow any OTP login (still store a token) so UI navigation works.
      final token = 'phone_${phoneNumber.trim()}';
      await _storage.write(key: _tokenKey, value: token);
      return;
    }

    final user = matches.first;
    final token = user['token']?.toString() ?? user['id']?.toString() ?? phoneNumber;
    await _storage.write(key: _tokenKey, value: token);
  }
}

