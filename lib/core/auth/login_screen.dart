import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  // Controllers are initialized as final members of the Stateless widget
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  // Function remains largely the same, but you must pass context 
  // or use a GlobalKey if you want to navigate from here
  void _handleLogin(BuildContext context) async {
    bool success = await _authService.login(
      _emailController.text, 
      _passwordController.text,
    );
    
    if (context.mounted) { // Always check if context is still valid after async call
      if (success) {
        // Navigate to Home Screen
        // Navigator.pushNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController, 
              decoration: const InputDecoration(labelText: 'Email')
            ),
            TextField(
              controller: _passwordController, 
              decoration: const InputDecoration(labelText: 'Password'), 
              obscureText: true
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _handleLogin(context), 
              child: const Text('Login')
            )
          ],
        ),
      ),
    );
  }
}