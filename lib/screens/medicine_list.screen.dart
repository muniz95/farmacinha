import 'package:farmacinha/bloc/medicine.bloc.dart';
import 'package:farmacinha/bloc/provider.dart';
import 'package:farmacinha/models/medicine.model.dart';
import 'package:farmacinha/components/drawer.dart';
import 'package:farmacinha/components/spinner.component.dart';
import 'package:flutter/material.dart';

class MedicineListScreen extends StatefulWidget{

  @override
  _MedicineListScreenState createState() => _MedicineListScreenState();

}

class _MedicineListScreenState extends State<MedicineListScreen> with TickerProviderStateMixin {
  MedicineBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= Provider.of(context).medicinebloc;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(),
      body: Container(
        child: StreamBuilder(
          initialData: _bloc.fetchAllMedicines(),
          stream: _bloc.medicineList,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Spinner();
            }

            List<Medicine> medicines = snapshot.data as List<Medicine>;
            if (medicines.length > 0) {
              return ListView.builder(
                itemCount: medicines.length,
                padding: new EdgeInsets.only(top: 5.0),
                itemBuilder: (context, index){

                  return Container(
                    margin: EdgeInsets.only(top: 15.0),
                    child: Card(
                      color: Colors.green,
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _bloc.selectMedicine(medicines[index]);
                            Navigator.of(context).pushNamed('medicine/form');
                          },
                        ),
                        title: Text(medicines[index].name, style: TextStyle(color: Colors.white),),
                      )
                    ),
                  );
                }
              );
            } else {
              return Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Nenhum medicamento encontrado!'),
                  ],
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          _bloc.selectMedicine(Medicine());
          Navigator.of(context).pushNamed('medicine/form');
        },
      ),
    );
  }

}