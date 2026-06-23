import 'package:flutter/material.dart';

class TrackingStatusDot extends StatelessWidget {
  final Color color;
  const TrackingStatusDot({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(width: 18, height: 18, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }
}

