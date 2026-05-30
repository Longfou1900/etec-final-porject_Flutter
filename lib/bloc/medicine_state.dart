// file: lib/bloc/
import '../models/medicine_model.dart';
abstract class MedicineState {}
class MedicineLoading extends MedicineState {}
class MedicineLoaded extends MedicineState {
  final List<Medicine> medicines;
  MedicineLoaded(this.medicines);
}
class MedicineError extends MedicineState {
  final String message;
  MedicineError(this.message);
}