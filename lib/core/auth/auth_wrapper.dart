import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class AuthWrapper extends StatelessWidget {
  final Widget child;
  final String title;
  const AuthWrapper({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3D5AFE),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                IconButton(icon: Icon(Icons.close, color: Colors.white), onPressed: () => Get.back()),
                Text(title, style: TextStyle(color: Colors.white, fontSize: 18))
              ]),
            ),
            Expanded(child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
              child: child,
            )),
          ],
        ),
      ),
    );
  }
}