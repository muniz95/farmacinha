import 'package:farmacinha/bloc/doctor.bloc.dart';
import 'package:farmacinha/bloc/provider.dart';
import 'package:farmacinha/components/drawer.dart';
import 'package:farmacinha/components/spinner.component.dart';
import 'package:farmacinha/models/doctor.model.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of(context).doctorbloc;

    // List<Task> _taskList;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      drawer: const AppDrawer(),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: StreamBuilder(
            initialData: _bloc.fetchDoctorList(),
            stream: _bloc.doctorList,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return _doctorsListing(_bloc, snapshot.data);
              } else {
                return const Spinner();
              }
            }),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _bloc.selectDoctor(Doctor());
          Navigator.of(context).pushNamed('doctor/form');
        },
        tooltip: 'Incrementar',
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget _doctorsListing(DoctorBloc bloc, List<Doctor> doctors) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
        Container(
          child: Center(
            child: Card(
              color: Colors.green,
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    bloc.selectDoctor(doctors[index]);
                    Navigator.of(context).pushNamed('doctor/form');
                  },
                ),
                title: Text(
                  doctors[index].toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      itemCount: doctors.length,
    );
  }
}
