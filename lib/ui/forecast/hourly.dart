import 'package:blue_sky/ui/locations/my_locations.dart';
import 'package:blue_sky/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final primaryColor = const Color(0xFF38B6FF);

class HourlyForecast extends StatefulWidget {
  final locationText;

  HourlyForecast({
    this.locationText
  });
  
  @override
  _HourlyForecastState createState() => _HourlyForecastState();
}

class _HourlyForecastState extends State<HourlyForecast> {
  @override
  Widget build(BuildContext context) {

    final PreferredSize appBar = PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: AppBar(
        title: Text(widget.locationText),
        backgroundColor: $Colors.primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.globeAmericas),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyLocationsPage()),
              );
            },
          ),
        ],
      ));

      return Scaffold(
        appBar: appBar
      );
  }
}

