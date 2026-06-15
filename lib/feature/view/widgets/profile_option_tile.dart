import 'package:flutter/material.dart';

class ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfileOptionTile({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:  Color(0xFF102A4B),
        borderRadius: BorderRadius.circular(20),
      ),
      padding:  EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70),
           SizedBox(width: 14),
          Text(
            title,
            style:  TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
           Spacer(),
           Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
        ],
      ),
    );
  }
}
