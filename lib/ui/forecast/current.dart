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
    if (widget.currentForecastObj == null) {
      return new Container();
    }
    return new Container(

      child: new Column(
        children: <Widget>[
          new Align(
            alignment: Alignment.topLeft,
            child: new Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 25.0),
              child: new Text(
                widget.currentForecastObj.temperature.toStringAsFixed(0) + '\u00B0',
                style: new TextStyle(
                  color: Colors.blue,
                  fontSize: 50.0,
                  
                ),
              ),
            ),
          ),
          new Align(
            alignment: Alignment.topLeft,
            child: new Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 10.0),
              child: new Text(
                widget.currentForecastObj.summary,
                style: new TextStyle(
                  color: Colors.blue,
                  fontSize: 40.0,
                  
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}