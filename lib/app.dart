import 'package:farmacinha/bloc/provider.dart';
import 'package:farmacinha/widgets/medicine_card.dart';
import 'package:farmacinha/widgets/spinner.dart';
import 'package:flutter/material.dart';

class FarmacinhaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Farmacinha',
        theme: new ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.redAccent
        ),
        home: new FarmacinhaPage(title: 'Lista de medicamentos'),
      )
    );
  }
}

class FarmacinhaPage extends StatelessWidget {
  FarmacinhaPage({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of(context).medicinebloc;

    // List<Task> _taskList;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
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