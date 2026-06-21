import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/core/auth/auth_wrapper.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      title: "Sign up",
      child: Column(
        children: [
          TextField(decoration: InputDecoration(labelText: "First name")),
          TextField(decoration: InputDecoration(labelText: "Last name")),
          TextField(decoration: InputDecoration(labelText: "Email")),
          TextField(decoration: InputDecoration(labelText: "Password", suffixIcon: Icon(Icons.visibility_off))),
          ElevatedButton(onPressed: () => Get.toNamed('/register-phone'), child: Text("Sign up")),
        ],
      ),
    );
  }
}