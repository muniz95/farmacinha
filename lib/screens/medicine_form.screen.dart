import 'package:farmacinha/bloc/medicine.bloc.dart';
import 'package:farmacinha/bloc/provider.dart';
import 'package:farmacinha/models/medicine.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MedicineFormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MedicineFormScreenState();
}

class _MedicineFormScreenState extends State<MedicineFormScreen> {
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  MedicineBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= Provider.of(context).medicinebloc;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
        stream: _bloc.selectedMedicine,
        builder: (BuildContext context, AsyncSnapshot snapshot) =>
            snapshot.hasData
                ? _hasDataWidget(_bloc, snapshot.data)
                : _loadingDataWidget());
  }

  Widget _hasDataWidget(MedicineBloc _bloc, Medicine medicine) => new Scaffold(
      appBar: new AppBar(
        title: new Text("Cadastro de medicamentos"),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Text(
              "Nova tarefa",
              textScaleFactor: 2.0,
            ),
            new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  _nameField(medicine),
                ],
              ),
            ),
            _submitBtn(_bloc, medicine),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ));

  Widget _loadingDataWidget() => new Center(
        child: new Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("Loading"),
            ],
          ),
        ),
      );

  Padding _nameField(Medicine medicine) => new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new TextFormField(
          textCapitalization: TextCapitalization.sentences,
          initialValue: medicine.name,
          onSaved: (val) {
            medicine.name = val;
          },
          validator: (val) {
            return val.length < 1 ? "Name must have atleast 1 chars" : null;
          },
          decoration: new InputDecoration(labelText: "Nome"),
        ),
      );

  void _submit(MedicineBloc bloc, Medicine medicine) async {
    final form = formKey.currentState;
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (form.validate()) {
      form.save();
      if (medicine.id != null) {
        await bloc.updateMedicine(medicine);
      } else {
        await bloc.addMedicine(medicine);
      }
    }
  }

  RaisedButton _submitBtn(MedicineBloc bloc, Medicine medicine) {
    return new RaisedButton(
      onPressed: () {
        _submit(bloc, medicine);
        Navigator.of(context).pop();
      },
      child: new Text("Salvar"),
    );
  }
}
