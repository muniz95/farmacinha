import 'package:farmacinha/screens/main_screen.dart';
import 'package:farmacinha/screens/medicine_form.dart';
import 'package:farmacinha/screens/medicine_list.dart';
import 'package:flutter/material.dart';

final routes = {
  'medicine/list': (BuildContext ctx) => new MedicineListScreen(),
  'medicine/form': (BuildContext ctx) => new MedicineFormScreen(),
  'home': (BuildContext ctx) => new MainScreen(),
};