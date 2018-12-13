import 'package:farmacinha/bloc/provider.dart';
import 'package:farmacinha/models/medicine.dart';
import 'package:farmacinha/widgets/drawer.dart';
import 'package:farmacinha/widgets/spinner.dart';
import 'package:flutter/material.dart';

class MedicineListScreen extends StatefulWidget{

  @override
  _MedicineListScreenState createState() => _MedicineListScreenState();

}


class _MedicineListScreenState extends State<MedicineListScreen> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context).medicinebloc;
    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(),
      body: Container(
        child: StreamBuilder(
          initialData: bloc.fetchMedicineList(),
          stream: bloc.medicineList,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Spinner();
            }

            List<Medicine> medicines = snapshot.data as List<Medicine>;
            ListView listView = new ListView.builder(
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
                          bloc.selectMedicine(medicines[index]);
                          Navigator.of(context).pushNamed('medicine/form');
                        },
                      ),
                      title: Text(medicines[index].name, style: TextStyle(color: Colors.white),),
                    )
                  ),
                );
              }
            );

            return listView;
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          bloc.selectMedicine(Medicine());
          Navigator.of(context).pushNamed('medicine/form');
        },
      ),
    );
  }

}