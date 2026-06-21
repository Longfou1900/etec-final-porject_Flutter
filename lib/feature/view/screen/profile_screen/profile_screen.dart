import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          // Profile Header Section
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: theme.primaryColor, width: 3),
                  ),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/150'),
                  ),
                ),
                const SizedBox(height: 16),
                Text("Jacob Josef",
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Text("jacob@gmail.com",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.hintColor)),
              ],
            ),
          ),
          const SizedBox(height: 30),
          // Menu Items
          _buildProfileItem(
              context, Icons.person_outline, "Edit Profile", () {}),
          _buildProfileItem(
              context, Icons.notifications_none, "Notifications", () {}),
          _buildProfileItem(
              context, Icons.lock_outline, "Privacy & Security", () {}),
          _buildProfileItem(
              context, Icons.help_outline, "Help & Support", () {}),
          const Divider(),
          // Inside your ProfileScreen build method's list:
          _buildProfileItem(
            context,
            Icons.logout,
            "Log Out",
            () {
              // 1. Perform your logout logic here (e.g., clear token, clear storage)
              // await authController.logout();
              // 2. Navigate to the Login screen and clear the navigation stack
              Get.offAllNamed('/onboarding');
            },
            isLogout: true,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap,
      {bool isLogout = false}) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: theme.cardColor, // Automatically adapts to Light/Dark mode
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: theme.shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading:
            Icon(icon, color: isLogout ? Colors.redAccent : theme.primaryColor),
        title: Text(title,
            style: TextStyle(
                color: isLogout
                    ? Colors.redAccent
                    : theme.textTheme.bodyLarge?.color,
                fontWeight: FontWeight.w500)),
        trailing: Icon(Icons.arrow_forward_ios,
            size: 16, color: theme.iconTheme.color),
      ),
    );
  }
}
