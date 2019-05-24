import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  const Spinner();
  
  @override
  Widget build(BuildContext context) {
    return Center(
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
  }

}