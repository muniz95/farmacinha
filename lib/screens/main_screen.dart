import 'package:farmacinha/bloc/provider.dart';
import 'package:farmacinha/widgets/drawer.dart';
import 'package:farmacinha/widgets/medicine_card.dart';
import 'package:farmacinha/widgets/spinner.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of(context).medicinebloc;

    // List<Task> _taskList;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      drawer: const FarmacinhaDrawer(),
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