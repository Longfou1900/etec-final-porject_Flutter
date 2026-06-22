// lib/feature/view/widgets/build_headerWave.dart
import 'package:flutter/material.dart';

Widget buildHeaderWave(BuildContext context, String title, {String? imageUrl}) {
  final theme = Theme.of(context);
  
  return Container(
    height: 240,
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [theme.primaryColor, theme.primaryColor.withOpacity(0.7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius:  BorderRadius.only(bottomLeft: Radius.circular(60)),
    ),
    padding:  EdgeInsets.only(left: 30, top: 40, right: 20),
    child: Row(
      children: [
        Expanded(
          child: Text(
            title,
            style:  TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),
          ),
        ),
        if (imageUrl != null)
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white24,
            backgroundImage: NetworkImage(imageUrl),
          ),
      ],
    ),
  );
}