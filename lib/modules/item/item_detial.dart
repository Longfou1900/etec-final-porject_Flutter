import 'package:flutter/material.dart';

class ItemDetail extends StatelessWidget {
  final int id;
  final int index;
  const ItemDetail({super.key, required this.id, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(id == 0 ? 'Popular' : 'Latest')),
      body: Center(child: Text(id.toString())),
    );
  }
}
