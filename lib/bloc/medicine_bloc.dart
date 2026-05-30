// file: lib/bloc/medicine_bloc.dart
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:etec_final_project_flutter_laravel/models/medicine_model.dart';

import 'medicine_event.dart';
import 'medicine_state.dart';
// import 'import_api_service_placeholder.dart'; // Assume standard API helper


// Helper class simulating your Laravel API integration
class ApiService {
  Future<List<dynamic>> fetchMedicines() async {
    // Your actual API call logic to Laravel database goes here
    return [];
  }
  
  Future<void> deleteMedicine(String id) async {
    // Your actual API delete call goes here
  }
}

class MedicineBloc extends Bloc<MedicineEvent, MedicineState> { 
  final ApiService apiService;

  MedicineBloc(this.apiService) : super(MedicineLoading()) { 
    
    on<FetchMedicines>((event, emit) async { 
      emit(MedicineLoading());
      try {
        // 1. Fetch the raw data items list
        final List<dynamic> rawData = await apiService.fetchMedicines();
        
        // 2. FIXED: Map the raw JSON list directly into a list of Medicine Models
        final List<Medicine> medicineList = rawData
            .map((json) => Medicine.fromJson(json))
            .toList();
        
        // 3. Emit the strict list type expected by MedicineLoaded state
        emit(MedicineLoaded(medicineList)); 
      } catch (e) {
        emit(MedicineError(e.toString()));
      }
    });

    on<DeleteMedicineItem>((event, emit) async { 
      try {
        await apiService.deleteMedicine(event.id);
        add(FetchMedicines()); // Automatically re-trigger list refresh fetch
      } catch (e) { 
        emit(MedicineError("Failed to delete medicine"));
      }
    });
  }
}