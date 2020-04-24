import 'package:farmacinha/screens/doctor_details.screen.dart';
import 'package:farmacinha/screens/doctor_form.screen.dart';
import 'package:farmacinha/screens/main.screen.dart';
import 'package:farmacinha/screens/medicine_form.screen.dart';
import 'package:farmacinha/screens/medicine_list.screen.dart';
import 'package:flutter/material.dart';

final routes = {
  'medicine/list': (BuildContext ctx) => new MedicineListScreen(),
  'medicine/form': (BuildContext ctx) => new MedicineFormScreen(),
  'doctor/form': (BuildContext ctx) => new DoctorFormScreen(),
  'doctor/details': (BuildContext ctx) => new DoctorDetailsScreen(),
  'home': (BuildContext ctx) => new MainScreen(),
};