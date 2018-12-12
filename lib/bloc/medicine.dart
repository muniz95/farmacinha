import 'package:rxdart/rxdart.dart';

class MedicineBloc {
  final BehaviorSubject<int> _total = BehaviorSubject<int>();
  Stream<int> get total => _total.stream;
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

  void dispose() {
    _total.close();
    _taskList.close();
  }
}