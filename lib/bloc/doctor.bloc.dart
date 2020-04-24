import 'package:farmacinha/models/doctor.model.dart';
import 'package:farmacinha/services/doctor.service.dart';
import 'package:rxdart/rxdart.dart';

class DoctorBloc {
  final DoctorService _service = new DoctorService();

  final BehaviorSubject<int> _total = BehaviorSubject<int>();
  Stream<int> get total => _total.stream;
  
  final BehaviorSubject<List<Doctor>> _doctorList = BehaviorSubject<List<Doctor>>();
  Stream<List<Doctor>> get doctorList => _doctorList.stream;
  
  final BehaviorSubject<Doctor> _selectedDoctor = BehaviorSubject<Doctor>();
  Stream<Doctor> get selectedDoctor => _selectedDoctor.stream;
  
  int get totalValue => _total.value;

  final BehaviorSubject<List<dynamic>> _taskList = BehaviorSubject<List<dynamic>>();
  Stream<List<dynamic>> get taskList => _taskList.stream;

  Function(void) get selectDoctor => _selectedDoctor.add;

  fetchDoctorList() {
    if (_doctorList.value == null) {
      _service.getAllDoctors().then(_doctorList.add);
    }
  }

  addDoctor(Doctor doctor) async {
    List<Doctor> doctors = _doctorList.value;
    if (await _service.saveDoctor(doctor) != null) {
      _doctorList.add(doctors..add(doctor));
    }
  }

  updateDoctor(Doctor doctor) async {
    if (await _service.updateDoctor(doctor) != null) {
      List<Doctor> doctors = _doctorList.value ?? new List<Doctor>();
      doctors.removeWhere((Doctor t) => t.id == doctor.id);
      doctors.add(doctor);
      _doctorList.add(doctors);
    }
  }

  void dispose() {
    _doctorList.close();
    _selectedDoctor.close();
    _total.close();
    _taskList.close();
  }
}