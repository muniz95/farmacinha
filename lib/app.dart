import 'package:farmacinha/bloc/provider.dart';
import 'package:farmacinha/routes.dart';
import 'package:farmacinha/screens/main.screen.dart';
import 'package:flutter/material.dart';

class FarmacinhaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        routes: routes,
        title: 'Farmacinha',
        theme: new ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.redAccent
        ),
        home: new MainScreen(title: 'Lista de medicamentos'),
      )
    );
  }
}