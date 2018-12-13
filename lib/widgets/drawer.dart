import 'package:flutter/material.dart';

class FarmacinhaDrawer extends StatelessWidget {
  const FarmacinhaDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.white],
                end: Alignment(1, 2),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.local_hospital),
            title: Text('Medicamentos'),
            onTap: () {
              Navigator.of(context).pushNamed('medicine/list');
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

}