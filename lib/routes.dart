import 'package:farmacinha/screens/main.screen.dart';
import 'package:farmacinha/screens/medicine_form.screen.dart';
import 'package:farmacinha/screens/medicine_list.screen.dart';
import 'package:flutter/material.dart';

final routes = {
  'medicine/list': (BuildContext ctx) => new MedicineListScreen(),
  'medicine/form': (BuildContext ctx) => new MedicineFormScreen(),
  'home': (BuildContext ctx) => new MainScreen(),
};