import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/core/auth/auth_wrapper.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class RegisterPhoneScreen extends StatelessWidget {
  const RegisterPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      title: "Register phone",
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              prefixText: "+62 ",
              hintText: "8xx-xxx-xxxx",
              labelText: 'Phone number',
            ),
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 9,
            itemBuilder: (ctx, i) => Center(child: Text("${i + 1}")),
          ),
          ElevatedButton(
            onPressed: () => Get.offAllNamed('/home'),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
