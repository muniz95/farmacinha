import 'package:farmacinha/bloc/provider.dart';
import 'package:farmacinha/models/medicine.dart';
import 'package:farmacinha/widgets/drawer.dart';
import 'package:farmacinha/widgets/spinner.dart';
import 'package:flutter/material.dart';

class MedicineListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context).medicinebloc;
    return Scaffold(
      appBar: AppBar(),
      drawer: const FarmacinhaDrawer(),
      body: Container(
        child: StreamBuilder(
          initialData: bloc.fetchMedicineList(),
          stream: bloc.medicineList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Spinner();
            }

            return Text((snapshot.data as List<Medicine>).length.toString());
          },
        ),
      ),
    );
  }

}