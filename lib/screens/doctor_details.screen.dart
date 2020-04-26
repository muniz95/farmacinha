import 'package:farmacinha/bloc/doctor.bloc.dart';
import 'package:farmacinha/bloc/medicine.bloc.dart';
import 'package:farmacinha/bloc/provider.dart';
import 'package:farmacinha/models/doctor.model.dart';
import 'package:farmacinha/models/medicine.model.dart';
import 'package:farmacinha/components/drawer.dart';
import 'package:farmacinha/components/spinner.component.dart';
import 'package:flutter/material.dart';

class DoctorDetailsScreen extends StatefulWidget {
  @override
  _DoctorDetailsScreenState createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen>
    with TickerProviderStateMixin {
  DoctorBloc _doctorbloc;
  MedicineBloc _medicinebloc;

  @override
  void didChangeDependencies() {
    _doctorbloc ??= Provider.of(context).doctorbloc;
    _medicinebloc ??= Provider.of(context).medicinebloc;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // _doctorbloc.dispose();
    // _medicinebloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(),
      body: Container(
        child: StreamBuilder(
          stream: _doctorbloc.selectedDoctorStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Spinner();
            }

            Doctor doctor = snapshot.data as Doctor;
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          doctor.name,
                          style: TextStyle(fontSize: 32),
                        ),
                        Text(
                          "CRM: ${doctor.crm}",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Especialidade: ${doctor.speciality}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                    initialData: _medicinebloc.fetchMedicineList(doctor),
                    stream: _medicinebloc.medicineList,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Text("Nenhum medicamento encontrado");
                      }
                      List<Medicine> medicines =
                          snapshot.data as List<Medicine>;
                      return Flexible(
                        child: ListView.builder(
                            itemCount: medicines.length,
                            padding: new EdgeInsets.only(top: 5.0),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(top: 15.0),
                                child: Card(
                                    color: Colors.green,
                                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: ListTile(
                                      leading: IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          _medicinebloc
                                              .selectMedicine(medicines[index]);
                                          Navigator.of(context)
                                              .pushNamed('medicine/form');
                                        },
                                      ),
                                      title: Text(
                                        medicines[index].timespan(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )),
                              );
                            }),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          var medicine = Medicine()..doctor = _doctorbloc.selectedDoctor;
          _medicinebloc.selectMedicine(medicine);
          Navigator.of(context).pushNamed('medicine/form');
        },
      ),
    );
  }
}
