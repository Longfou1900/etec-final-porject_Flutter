import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/view/widgets/build_headerWave.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // Added image URL here
          buildHeaderWave(context, "Log In!",
              imageUrl:
                  "https://i.pinimg.com/1200x/57/05/5b/57055bd6256c8768669aadb96b35d128.jpg"),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
              child: Column(
                children: [
                  _buildInputField(context, emailController, "Email Address",
                      Icons.email_outlined),
                  SizedBox(height: 20),
                  _buildInputField(context, passwordController, "Password",
                      Icons.lock_outline,
                      obscure: true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: Text("Forgot password?")),
                  ),
                  SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: theme.primaryColor.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(0, 5))
                      ],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        foregroundColor: theme.colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () => Get.offAllNamed('/home'),
                      child: Text("Log in",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInputField(BuildContext context,
      TextEditingController controller, String label, IconData icon,
      {bool obscure = false}) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: theme.primaryColor),
        filled: true,
        fillColor: theme.cardColor,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      ),
    );
  }
}
