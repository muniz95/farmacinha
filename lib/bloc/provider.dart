import 'package:farmacinha/bloc/doctor.bloc.dart';
import 'package:farmacinha/bloc/medicine.bloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final Widget child;
  final MedicineBloc medicinebloc = new MedicineBloc();
  final DoctorBloc doctorbloc = new DoctorBloc();

  Provider({this.child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}