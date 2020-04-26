import 'package:farmacinha/bloc/doctor.bloc.dart';
import 'package:farmacinha/bloc/provider.dart';
import 'package:farmacinha/models/doctor.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoctorFormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DoctorFormScreenState();
}

class _DoctorFormScreenState extends State<DoctorFormScreen> {
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  DoctorBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= Provider.of(context).doctorbloc;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
        stream: _bloc.selectedDoctorStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Doctor doctor = snapshot.data as Doctor;
            doctor.locals = [];
            return _hasDataWidget(_bloc, doctor);
          } else {
            return _loadingDataWidget();
          }
        });
  }

  Widget _hasDataWidget(DoctorBloc _bloc, Doctor doctor) => new Scaffold(
      appBar: new AppBar(
        title: new Text("Cadastro de médicos"),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Text(
              "Novo médico",
              textScaleFactor: 2.0,
            ),
            new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  _nameField(doctor),
                  _crmField(doctor),
                  _specialityField(doctor),
                ],
              ),
            ),
            _submitBtn(_bloc, doctor),
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

  Padding _nameField(Doctor doctor) => new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new TextFormField(
          textCapitalization: TextCapitalization.sentences,
          initialValue: doctor.name,
          onSaved: (val) {
            doctor.name = val;
          },
          validator: (val) {
            return val.length < 1 ? "Name must have atleast 1 chars" : null;
          },
          decoration: new InputDecoration(labelText: "Nome"),
        ),
      );

  Padding _crmField(Doctor doctor) => new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new TextFormField(
          keyboardType: TextInputType.number,
          textCapitalization: TextCapitalization.sentences,
          initialValue: doctor.crm.toString(),
          onSaved: (val) {
            doctor.crm = int.parse(val);
          },
          validator: (val) {
            return val.length < 1 ? "CRM must have atleast 1 chars" : null;
          },
          decoration: new InputDecoration(labelText: "CRM"),
        ),
      );

  Padding _specialityField(Doctor doctor) => new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new TextFormField(
          textCapitalization: TextCapitalization.sentences,
          initialValue: doctor.speciality,
          onSaved: (val) {
            doctor.speciality = val;
          },
          validator: (val) {
            return val.length < 1
                ? "Speciality must have atleast 1 chars"
                : null;
          },
          decoration: new InputDecoration(labelText: "Especialidade"),
        ),
      );

  void _submit(DoctorBloc bloc, Doctor doctor) async {
    final form = formKey.currentState;
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (form.validate()) {
      form.save();
      if (doctor.id != null) {
        await bloc.updateDoctor(doctor);
      } else {
        await bloc.addDoctor(doctor);
      }
    }
  }

  RaisedButton _submitBtn(DoctorBloc bloc, Doctor doctor) {
    return new RaisedButton(
      onPressed: () {
        _submit(bloc, doctor);
        Navigator.of(context).pop();
      },
      child: new Text("Salvar"),
    );
  }
}
