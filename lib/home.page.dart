import 'dart:async';
import 'dart:convert';

import 'package:blue_sky/forecast/current.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/geolocation.dart';
import 'package:http/http.dart' as http;

import './forecast/hourly.dart' as hourlyForecast;
import './forecast/daily.dart' as dailyForecast;
import './models/current_forecast.dart';
import 'package:rxdart/rxdart.dart';

import './models/location_data.dart';

final primaryColor = const Color(0xFF38B6FF);

class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  LocationData _locationData;
  Current _currentForecast;

  bool isBusy = false;

  final PublishSubject subject = PublishSubject<String>();

  @override
  void initState() {
    isBusy = true;
    super.initState();
    _initialize();
    controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    controller.dispose();
    subject.close();
    super.dispose();
  }

  _initialize() async {
    final location = await _getCoords();
    final result = location.location;

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

    getForecast(result.latitude.toString(), result.longitude.toString()).then((current) {
      setState(() {
        _currentForecast = current;
      });
    });
  
  }

  Future<LocationResult> _getCoords() async {
    Future<LocationResult> result = Geolocation.lastKnownLocation();
    return result;
  }

  Future<http.Response> _getAddress(double lat, double lng) async {
    final uri = Uri.https(
      'us-central1-blue-sky-bfafb.cloudfunctions.net',
      '/geocoding',
      {'latitude': '${lat.toString()}', 'longitude': '${lng.toString()}'},
    );
    return await http.get(uri);
  }

  Future<Current> getForecast(String lat, String lng) async {
    
    final http.Client _client = new http.Client();
    var url = 'https://us-central1-blue-sky-bfafb.cloudfunctions.net/darkSkyProxy?latitude=${lat.toString()}&longitude=${lng.toString()}';
    return await _client
    .get(Uri.parse(url))
    .then((res) => res.body)
    .then(json.decode)
    .then((json) => json['currently'])
    .then((jsonCurrent) => new Current.fromJson(jsonCurrent));
  }


  @override
  Widget build(BuildContext context) {
    if (_locationData == null) {
      return new Container();
    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(_locationData.suburb + ', ' + _locationData.city),
          backgroundColor: primaryColor,
          actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {
                print('pressed');
              },
            ),
          ],
          bottom: new TabBar(
            controller: controller,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              new Tab(text: 'Now'),
              new Tab(text: 'Hourly'),
              new Tab(text: 'Daily'),
            ],
          ),
        ),
        drawer: new Drawer(
          child: new ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header',
                    style: new TextStyle(color: Colors.white)),
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
              ),
              new ListTile(
                title: new Text('My Locations'),
                trailing: new Icon(Icons.location_on),
                onTap: () {
                  print('pressed');
                },
              ),
              new Divider(),
              new ListTile(
                title: new Text('Settings'),
                trailing: new Icon(Icons.settings),
                onTap: () {
                  //do something here
                },
              ),
              new Divider(),
              new ListTile(
                title: new Text('Uinits'),
                trailing: new Icon(Icons.settings),
                onTap: () {
                  //do something here
                },
              ),
            ],
          ),
        ),
        body: new TabBarView(
          controller: controller,
          children: <Widget>[
            new CurrentForecast(currentForecastObj: this._currentForecast),
            new hourlyForecast.HourlyForecast(),
            new dailyForecast.DailyForecast(),
          ],
        ));
  }
}
