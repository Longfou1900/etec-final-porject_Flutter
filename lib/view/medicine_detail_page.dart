// file: lib/pages/medicine_detail_page.dart
import 'package:etec_final_project_flutter_laravel/constants/material.dart';
import 'package:flutter/material.dart';
import '../models/medicine_model.dart';

class MedicineDetailPage extends StatelessWidget {
  final Medicine medicine;
  final bool isAdmin;

  const MedicineDetailPage({Key? key, required this.medicine, required this.isAdmin}) : super(key: key);

  void _showImageDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InteractiveViewer(
              child: Image.network(medicine.image, fit: BoxFit.contain),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                medicine.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medicine.name),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _showImageDetailsDialog(context),
              child: Center(
                child: Hero(
                  tag: medicine.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(medicine.image, height: 250, width: double.infinity, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("ព័ត៌មានលម្អិត / Details", style: Theme.of(context).textTheme.headlineMedium),
            const Divider(),
            Text("ប្រភេទ (Type): ${medicine.type}", style: AppTheme.lightTheme.textTheme.bodyLarge),
            Text("តម្លៃ (Price): \$${medicine.price.toStringAsFixed(2)}", style: AppTheme.lightTheme.textTheme.bodyLarge),
            Text("ចំនួនក្នុងស្តុក (Stock Qty): ${medicine.qty}", style: AppTheme.lightTheme.textTheme.bodyLarge),
            Text("មកពីប្រទេស (Country): ${medicine.country}", style: AppTheme.lightTheme.textTheme.bodyLarge),
            const SizedBox(height: 10),
            Text("Description: ${medicine.description}"),
            const SizedBox(height: 30),
            if (isAdmin)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.dangerColor),
                onPressed: () {
                  // Fire BLoC delete event here
                },
                icon: const Icon(Icons.delete),
                label: const Text("លុបថ្នាំនេះចេញ (Delete Medicine)"),
              )
          ],
        ),
      ),
    );
  }
}