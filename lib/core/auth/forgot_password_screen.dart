import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/core/auth/auth_wrapper.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      title: "Forgot password?",
      child: Column(
        children: [
          Text("Enter your email address to reset your password"),
          TextField(decoration: InputDecoration(labelText: "Email")),
          ElevatedButton(onPressed: () {}, child: Text("Send link")),
        ],
      ),
    );
  }
}