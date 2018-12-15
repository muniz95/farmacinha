import 'package:farmacinha/models/medicine_model.dart';
import 'package:farmacinha/services/medicine_service.dart';
import 'package:rxdart/rxdart.dart';

class MedicineBloc {
  final MedicineService _service = new MedicineService();

  final BehaviorSubject<int> _total = BehaviorSubject<int>();
  Stream<int> get total => _total.stream;
  
  final BehaviorSubject<List<Medicine>> _medicineList = BehaviorSubject<List<Medicine>>();
  Stream<List<Medicine>> get medicineList => _medicineList.stream;
  
  final BehaviorSubject<Medicine> _selectedMedicine = BehaviorSubject<Medicine>();
  Stream<Medicine> get selectedMedicine => _selectedMedicine.stream;
  
  int get totalValue => _total.value;

  final BehaviorSubject<List<dynamic>> _taskList = BehaviorSubject<List<dynamic>>();
  Stream<List<dynamic>> get taskList => _taskList.stream;

  Function(void) get selectMedicine => _selectedMedicine.add;

  increment() {
    _total.add(_total.value + 1);
  }

  decrement() {
    _total.add(_total.value - 1);
  }

  fetchTotal() {
    _total.add(1);
  }

  fetchMedicineList() {
    if (_medicineList.value == null) {
      _service.getAllMedicines().then(_medicineList.add);
    }
  }

  addMedicine(Medicine medicine) async {
    List<Medicine> medicines = _medicineList.value;
    if (await _service.saveMedicine(medicine) != null) {
      _medicineList.add(medicines..add(medicine));
    }
  }

  updateMedicine(Medicine medicine) async {
    if (await _service.updateMedicine(medicine) != null) {
      List<Medicine> medicines = _medicineList.value ?? new List<Medicine>();
      medicines.removeWhere((Medicine t) => t.id == medicine.id);
      medicines.add(medicine);
      _medicineList.add(medicines);
    }
  }

  void dispose() {
    _medicineList.close();
    _selectedMedicine.close();
    _total.close();
    _taskList.close();
  }
}