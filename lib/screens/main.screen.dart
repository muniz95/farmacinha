import 'package:farmacinha/bloc/provider.dart';
import 'package:farmacinha/components/drawer.dart';
import 'package:farmacinha/components/medicine_card.component.dart';
import 'package:farmacinha/components/spinner.component.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of(context).medicinebloc;

    // List<Task> _taskList;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      drawer: const AppDrawer(),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: StreamBuilder(
          initialData: _bloc.fetchTotal(),
          stream: _bloc.total,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              int total = snapshot.data as int;
              return MedicineCard(total, _bloc);
            }
            else {
              return const Spinner();
            } 
          }
        ),
      ),      
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _bloc.increment();
        },
        tooltip: 'Incrementar',
        child: new Icon(Icons.add),
      ),
    );
  }
}