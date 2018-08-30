import 'package:blue_sky/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class MyLocationsPage extends StatefulWidget {
  @override
  _MyLocationsPageState createState() => _MyLocationsPageState();
}

class _MyLocationsPageState extends State<MyLocationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: $Colors.primaryColor,
        title: Text("My Locations"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}