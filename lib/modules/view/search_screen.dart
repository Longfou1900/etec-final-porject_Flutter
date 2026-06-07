import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFF0D1B2A),
      appBar: AppBar(
        backgroundColor:  Color(0xFF0D1B2A),
        elevation: 0,
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title:  Text('Search', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(20),
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics:  BouncingScrollPhysics(),
            children: [
              Container(
                decoration: BoxDecoration(
                  color:  Color(0xFF142A45),
                  borderRadius: BorderRadius.circular(18),
                ),
                child:  TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.white70),
                    hintText: 'Search products',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
              ),
               SizedBox(height: 24),
               Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent searches',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
               SizedBox(height: 14),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children:  [
                  _SearchTag('Chronograph'),
                  _SearchTag('Apple Watch'),
                  _SearchTag('Luxury'),
                  _SearchTag('Minimalist'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchTag extends StatelessWidget {
  final String label;

  const _SearchTag(this.label);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style:  TextStyle(color: Colors.white)),
      backgroundColor:  Color(0xFF142A45),
      side:  BorderSide(color: Colors.white12),
    );
  }
}
