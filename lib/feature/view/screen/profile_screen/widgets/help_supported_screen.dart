import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Support", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          // Modern Header Section
          const SizedBox(height: 10),
          Text(
            "How can we help?",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Find answers to your questions or get in touch with our team.",
            style: TextStyle(color: colorScheme.outline, fontSize: 16),
          ),
          const SizedBox(height: 32),

          // Action Items
          _buildSupportCard(
            context,
            icon: Icons.mail_outline_rounded,
            title: "Contact Support",
            subtitle: "Get help via email",
            onTap: () {},
          ),
          _buildSupportCard(
            context,
            icon: Icons.article_outlined,
            title: "FAQ",
            subtitle: "Read our frequently asked questions",
            onTap: () {},
          ),
          _buildSupportCard(
            context,
            icon: Icons.info_outline_rounded,
            title: "About Us",
            subtitle: "Learn more about our mission",
            onTap: () {},
          ),
          
          const SizedBox(height: 40),
          Center(
            child: Text("Version 1.0.0", style: TextStyle(color: colorScheme.outline)),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: colorScheme.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(color: colorScheme.outline)),
        trailing: Icon(Icons.chevron_right, color: colorScheme.outline),
        onTap: onTap,
      ),
    );
  }
}