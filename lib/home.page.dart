import 'dart:async';
import 'dart:convert';
import 'package:blue_sky/models/current_forecast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './forecast/hourly.dart' as hourlyForecast;
import './forecast/daily.dart' as dailyForecast;
import './forecast/current.dart' as currentForecast;

import 'package:location/location.dart' as geoloc;
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
  //CurrentForecastViewModel _currentForcast;

  @override
  void initState() {
    super.initState();
    getLocation();
    controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  Future<String> _getAddress(double lat, double lng) async {
    final uri = Uri.https(
      'us-central1-blue-sky-bfafb.cloudfunctions.net',
      '/googleGeocoding',
      {'latitude': '${lat.toString()}', 'longitude': '${lng.toString()}'},
    );

    final http.Response response = await http.get(uri);

    setState(() {
      final decodedResponse = json.decode(response.body);

      _locationData = LocationData(
          city: decodedResponse['city'],
          district: decodedResponse['district'],
          latitude: lat,
          longitude: lng);
    });

    return "Success!";
  }

  getLocation() async {
    final location = geoloc.Location();
    final currentLocation = await location.getLocation;
    return await _getAddress(
        currentLocation['latitude'], currentLocation['longitude']);
  }

  Future<String> getforecast(double lat, double lng) async {
    final uri = Uri.https(
      'us-central1-blue-sky-bfafb.cloudfunctions.net',
      '/darkSkyProxy',
      {'latitude': '${lat.toString()}', 'longitude': '${lng.toString()}'},
    );

    final http.Response response = await http.get(uri);
    final decodedResponse = json.decode(response.body);
    print(decodedResponse);

    return "Success!";

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(_locationData.district + ', ' + _locationData.city),
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
            new currentForecast.CurrentForecast(),
            new hourlyForecast.HourlyForecast(),
            new dailyForecast.DailyForecast(),
          ],
        ));
  }
}
