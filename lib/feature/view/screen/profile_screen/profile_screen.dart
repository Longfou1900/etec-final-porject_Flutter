import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_projects_getx/feature/controller/profile/edit_profile_controller.dart';
import 'package:flutter_projects_getx/feature/view/screen/profile_screen/widgets/PrivacySecurityScreen.dart';
import 'package:flutter_projects_getx/feature/view/screen/profile_screen/widgets/edit_profile_screen.dart';
import 'package:flutter_projects_getx/feature/view/screen/profile_screen/widgets/help_supported_screen.dart';
import 'package:flutter_projects_getx/feature/view/screen/profile_screen/widgets/notification_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller =
        Get.put(ProfileController(), permanent: true);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text("Profile",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Obx(() => Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: colorScheme.primary.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10))
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: colorScheme.primary,
                        backgroundImage: controller.selectedImage.value != null
                            ? FileImage(controller.selectedImage.value!)
                            : null,
                        child: controller.selectedImage.value == null
                            ? Icon(Icons.person,
                                size: 60, color: colorScheme.onPrimary)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(controller.name.value,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    Text(controller.email.value,
                        style: TextStyle(
                            color: colorScheme.outline, fontSize: 14)),
                  ],
                )),
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withOpacity(0.2),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                    color: colorScheme.outlineVariant.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  _buildMenuItem(Icons.person_outline, "Edit Profile",
                      () => Get.to(() => const EditProfileScreen())),
                  // No divider here as requested
                  const Divider(indent: 60, height: 1),
                  _buildMenuItem(Icons.notifications_none, "Notifications",
                      () => Get.to(() => const NotificationsScreen())),
                  const Divider(indent: 60, height: 1),
                  _buildMenuItem(Icons.lock_outline, "Privacy & Security",
                      () => Get.to(() => const PrivacySecurityScreen())),
                  const Divider(indent: 60, height: 1),
                  _buildMenuItem(Icons.help_outline, "Help & Support",
                      () => Get.to(() => const HelpSupportScreen())),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  controller.resetProfileData();
                  Get.offAllNamed('/splash');
                },
                icon: Icon(Icons.logout, color: colorScheme.error),
                label: Text("Log Out",
                    style: TextStyle(
                        color: colorScheme.error, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: colorScheme.error.withOpacity(0.5)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Get.theme.colorScheme.primaryContainer,
            shape: BoxShape.circle),
        child: Icon(icon,
            size: 20, color: Get.theme.colorScheme.onPrimaryContainer),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: Icon(Icons.chevron_right, color: Get.theme.colorScheme.outline),
    );
  }
}
