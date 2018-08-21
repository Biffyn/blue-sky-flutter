import 'package:blue_sky/models/current_forecast.dart';
import 'package:flutter/material.dart';
 
class CurrentForecast extends StatefulWidget  {
 final currentForecastObj;
  CurrentForecast({
    this.currentForecastObj
  });
  @override
  _CurrentForecastState createState() => new _CurrentForecastState();
}

class _CurrentForecastState extends State<CurrentForecast> {

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Text(widget.currentForecastObj.summary,
        style: new TextStyle(fontSize: 25.0, color: Colors.blueAccent),
      ),
      ),
    );
  }
}