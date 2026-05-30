abstract class MedicineEvent {}
class FetchMedicines extends MedicineEvent {}
class SearchSortMedicines extends MedicineEvent {
  final String query;
  final String sortType;
  SearchSortMedicines({required this.query, required this.sortType});
}
class DeleteMedicineItem extends MedicineEvent {
  final String id;
  DeleteMedicineItem(this.id);
}

