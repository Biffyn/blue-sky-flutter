import 'dart:async';
import 'dart:convert';

import 'package:blue_sky/models/current_forecast.dart';
import 'package:blue_sky/models/currently_model.dart';
import 'package:blue_sky/models/forecast_model.dart';
import 'package:http/http.dart' as http;
import 'package:blue_sky/models/location_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'package:rxdart/rxdart.dart';

import './ui/forecast/current.dart';
import './ui/forecast/hourly.dart';
import './ui/forecast/daily.dart';
import './ui/radar/radar.dart';
import './ui/locations/my_locations.dart';
import 'package:blue_sky/ui/theme/theme.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  HomePage({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  LocationData _locationData;
  Forecast _forecast;
  Currently _currently;
  String _locationText;
  bool isLoading = false;
  bool isLocationWithSuburb = false;
  int _currentIndex = 0;

  final PublishSubject subject = PublishSubject<String>();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    subject.close();
    super.dispose();
  }

  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }

  _initialize() async {
    final Position location = await _getCoords();
    final Position result = location;

    _getAddress(result.latitude, result.longitude).then((res) {
      setState(() {
        final decodedResponse = json.decode(res.body);
        _locationData = LocationData(
            city: decodedResponse['city'],
            suburb: decodedResponse['suburb'],
            latitude: decodedResponse['latitude'],
            longitude: decodedResponse['longitude']);
      });
    });

    getForecast(result.latitude.toString(), result.longitude.toString()).then((res) {
        setState(() {
          final decodedResponse = json.decode(res.body);
          Forecast forecast = new Forecast.fromJson(decodedResponse);
          _forecast = forecast;
          _currently = _forecast.currently;
          isLoading = false;
        });

    });
  }

  Future<Position> _getCoords() async {
    Position position =
        await Geolocator().getLastKnownPosition(LocationAccuracy.high);
    return position;
  }

  Future<http.Response> _getAddress(double lat, double lng) async {
    final Uri uri = Uri.https(
      'us-central1-blue-sky-bfafb.cloudfunctions.net',
      '/geocoding',
      {'latitude': '${lat.toString()}', 'longitude': '${lng.toString()}'},
    );
    return await http.get(uri);
  }

  Future<http.Response> getForecast(String lat, String lng) async {

    setState(() {
      isLoading = true;
    });

    var url =
        'https://us-central1-blue-sky-bfafb.cloudfunctions.net/darkSkyProxy?latitude=${lat.toString()}&longitude=${lng.toString()}';

    return await http.get(Uri.parse(url));

  }

  @override
  Widget build(BuildContext context) {
    if (_locationData == null) {
      return new Container();
    } else {
      if (_locationData.suburb == null) {
        isLocationWithSuburb = false;
      } else {
        isLocationWithSuburb = true;
      }
      _locationText = isLocationWithSuburb ? _locationData.suburb + ', ' + _locationData.city : _locationData.city;
    }

    final PreferredSize appBar = PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: AppBar(
        title: Text(_locationText),
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

    final Drawer drawer = new Drawer(
      child: new ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
         new DrawerHeader(
            child: Text('Drawer Header', style: TextStyle(color: Colors.white)),
            decoration: BoxDecoration(
              color: $Colors.primaryColor,
            ),
          ),
          ListTile(
            title: Text('My Locations'),
            trailing: Icon(Icons.location_on),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(                 
                  builder: (context) => MyLocationsPage()
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Settings'),
            trailing: Icon(Icons.settings),
            onTap: () {
              //do something here
            },
          ),
          Divider(),
          ListTile(
            title: Text('Units'),
            trailing: Icon(Icons.settings),
            onTap: () {
              //do something here
            },
          ),
        ],
      ),
    );

    final List<Widget> _children = [
      CurrentForecast(currentForecastObj: _currently, locationText: _locationText),
      HourlyForecast(locationText: _locationText),
      MyLocationsPage(),
      HourlyForecast(locationText: _locationText)
    ];

    final BottomNavigationBar nav = new BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.umbrella), title: Text("Summary")),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.clock), title: Text("Hourly")),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.calendarAlt), title: Text("Daily")),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.map), title: Text("Radar"))
      ],
      onTap: onTabTapped,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
    );

    return new Scaffold(
      drawer: drawer, 
      body: isLoading ? Center(child: CircularProgressIndicator()) : _children[_currentIndex],
      bottomNavigationBar: nav
    );
  }
}
