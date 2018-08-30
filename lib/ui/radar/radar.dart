import 'package:flutter/material.dart';

class RadarPage extends StatefulWidget {
  @override
  _RadarPageState createState() => _RadarPageState();
}

class _RadarPageState extends State<RadarPage> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Text('Radar Page',
        style: new TextStyle(fontSize: 25.0, color: Colors.blueAccent),
      ),
      ),
    );
  }
}