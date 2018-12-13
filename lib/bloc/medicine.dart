import 'package:farmacinha/models/medicine.dart';
import 'package:rxdart/rxdart.dart';

class MedicineBloc {
  final BehaviorSubject<int> _total = BehaviorSubject<int>();
  Stream<int> get total => _total.stream;
  
  final BehaviorSubject<List<Medicine>> _medicineList = BehaviorSubject<List<Medicine>>();
  Stream<List<Medicine>> get medicineList => _medicineList.stream;
  
  int get totalValue => _total.value;

  final BehaviorSubject<List<dynamic>> _taskList = BehaviorSubject<List<dynamic>>();
  Stream<List<dynamic>> get taskList => _taskList.stream;

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
      _medicineList.add(
        new List<Medicine>()..addAll([Medicine(), Medicine(), Medicine(), Medicine()])
      );
    }
  }

  void dispose() {
    _medicineList.close();
    _total.close();
    _taskList.close();
  }
}