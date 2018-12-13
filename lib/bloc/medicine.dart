import 'package:farmacinha/models/medicine.dart';
import 'package:rxdart/rxdart.dart';

class MedicineBloc {
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
      Future.delayed(Duration(seconds: 3), () {
        _medicineList.add(
          new List<Medicine>()..addAll([
            Medicine(name: 'teste'), Medicine(name: 'teste'), Medicine(name: 'teste'), Medicine(name: 'teste')
          ])
        );
      });
    }
  }

  addMedicine(Medicine medicine) {
    List<Medicine> medicines = _medicineList.value;
    _medicineList.add(medicines..add(medicine));
  }

  updateMedicine(Medicine medicine) {
    List<Medicine> medicines = _medicineList.value;
    _medicineList.add(medicines..add(medicine));
  }

  void dispose() {
    _medicineList.close();
    _selectedMedicine.close();
    _total.close();
    _taskList.close();
  }
}