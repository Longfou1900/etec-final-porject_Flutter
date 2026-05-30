import 'package:etec_final_project_flutter_laravel/bloc/medicine_bloc.dart';
import 'package:etec_final_project_flutter_laravel/models/medicine_model.dart';
import 'package:etec_final_project_flutter_laravel/view/home.dart';
import 'package:etec_final_project_flutter_laravel/view/medicine_detail_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 1. Initialize your ApiService dependency
    final apiService = ApiService();

    // 2. Create sample dummy data for testing the UI rendering
    final Medicine sampleMedicine = Medicine(
      id: "MED-1029",
      name: "Paracetamol 500mg",
      description:
          "ប្រើប្រាស់សម្រាប់បំបាត់ការឈឺចាប់ និងបញ្ចុះកម្តៅ (For relieving pain and reducing fever).",
      dateIn: DateTime.now(),
      dateOut: DateTime.now().add(const Duration(days: 365)),
      stock: 500,
      image:
          "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?q=80&w=600&auto=format&fit=crop", // Clean placeholder image
      price: 2.50,
      qty: 120,
      country: "Cambodia",
      type: "Tablet",
    );

    // 3. Set your initial authorization state for UI testing
    const bool isAdminUser = true;

    return MaterialApp(
      home: MedicineDetailPage(medicine: sampleMedicine, isAdmin: isAdminUser),
      debugShowCheckedModeBanner: false,
    );
  }
}
