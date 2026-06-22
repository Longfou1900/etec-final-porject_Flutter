import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy & Security",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          _buildSectionHeader("Account Security"),
          _buildModernTile(
            context,
            icon: Icons.vpn_key_outlined,
            title: "Change Password",
            subtitle: "Update your password regularly",
            onTap: () {},
          ),
          _buildModernTile(
            context,
            icon: Icons.security_outlined,
            title: "Two-Factor Authentication",
            subtitle: "Add an extra layer of security",
            onTap: () {},
            trailing: Switch(value: true, onChanged: (v) {}),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader("Privacy"),
          _buildModernTile(
            context,
            icon: Icons.block_outlined,
            title: "Blocked Users",
            subtitle: "Manage your blocked list",
            onTap: () {},
          ),
          _buildModernTile(
            context,
            icon: Icons.visibility_off_outlined,
            title: "Profile Visibility",
            subtitle: "Manage who can see your profile",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(Get.context!).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildModernTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return Card(
      elevation: 0,
      color: Theme.of(context)
          .colorScheme
          .surfaceContainerHighest
          .withOpacity(0.3),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle,
            style: TextStyle(
                fontSize: 12, color: Theme.of(context).colorScheme.outline)),
        trailing: trailing ?? const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
