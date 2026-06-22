import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          _buildSectionTitle("General"),
          _buildNotificationCard(
            title: "Push Notifications",
            subtitle: "Receive alerts for app updates",
            value: true,
            onChanged: (val) {},
          ),
          _buildNotificationCard(
            title: "Email Notifications",
            subtitle: "Receive weekly activity summaries",
            value: false,
            onChanged: (val) {},
          ),
          const SizedBox(height: 20),
          _buildSectionTitle("Activity"),
          _buildNotificationCard(
            title: "Mentions",
            subtitle: "Notify when someone tags you",
            value: true,
            onChanged: (val) {},
          ),
          _buildNotificationCard(
            title: "Reminders",
            subtitle: "Get reminded of your pending tasks",
            value: true,
            onChanged: (val) {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
      child: Text(
        title,
        style: TextStyle(
          color: Get.theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Card(
      elevation: 0,
      color: Get.theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 12),
      child: SwitchListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle,
            style:
                TextStyle(fontSize: 12, color: Get.theme.colorScheme.outline)),
        value: value,
        onChanged: onChanged,
        activeColor: Get.theme.colorScheme.primary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
