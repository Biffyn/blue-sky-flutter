import 'package:flutter/material.dart';
 
class DailyForecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      
      child: new Center(
        child: new Text('Daily Forecast',
        style: new TextStyle(fontSize: 25.0, color: Colors.blueAccent),
      ),
      ),
    );
  }
}