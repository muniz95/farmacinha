import 'package:farmacinha/bloc/medicine.bloc.dart';
import 'package:flutter/material.dart';

class MedicineCard extends StatelessWidget {
  final int total;
  final MedicineBloc bloc;
  
  const MedicineCard(this.total, this.bloc);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('$total'),
        ],
      ),
    );
  }

}