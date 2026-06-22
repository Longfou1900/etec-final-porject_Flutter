import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/core/auth/auth_theme.dart';
import 'package:flutter_projects_getx/feature/controller/profile/edit_profile_controller.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Image Picker Section with Edit Button
            GestureDetector(
              onTap: () => controller.pickImage(),
              child: Obx(() => Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      // Modern Container with shadow and border
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 62, // Slightly larger for a premium feel
                          backgroundColor: AuthTheme.primaryDark,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primaryContainer
                                .withOpacity(0.5),
                            backgroundImage:
                                controller.selectedImage.value != null
                                    ? FileImage(controller.selectedImage.value!)
                                    : null,
                            child: controller.selectedImage.value == null
                                ? Icon(Icons.person,
                                    size: 60,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer
                                        .withOpacity(0.5))
                                : null,
                          ),
                        ),
                      ),

                      // Modern "Floating" Edit Button
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.edit_rounded,
                            size: 20, color: Colors.white),
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: controller.nameController,
              decoration: const InputDecoration(
                  labelText: "Full Name", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller
                  .emailController, // Ensure this exists in your controller
              decoration: const InputDecoration(
                  labelText: "Email Address", border: OutlineInputBorder()),
            ),

            const SizedBox(height: 30),
// 2. Modern Save Button
            SizedBox(
              width: double.infinity,
              height: 56, // Slightly taller for better touch target
              child: FilledButton.tonal(
                // Tonal variant looks very premium
                onPressed: () => controller.saveProfile(),
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0, // Flat design is modern
                ),
                child: const Text("Save Changes",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
