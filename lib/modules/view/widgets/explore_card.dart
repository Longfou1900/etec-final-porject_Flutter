import 'package:flutter/material.dart';

class ExploreCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const ExploreCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color:  Color(0xFF10243F),
        borderRadius: BorderRadius.circular(24),
      ),
      padding:  EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color:  Color(0xFF172F4F),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
           Spacer(),
          Text(
            title,
            style:  TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
           SizedBox(height: 10),
           Text(
            'Premium watch picks to elevate your style.',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
