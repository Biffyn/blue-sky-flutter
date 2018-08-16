import 'package:flutter/material.dart';

import './forecast/hourly.dart' as hourlyForecast;
import './forecast/daily.dart' as dailyForecast;
import './forecast/current.dart' as currentForecast;

import 'package:geolocation/geolocation.dart';

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Westerberg, Osnabrück'),
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
                title: new Text('Home'),
                trailing: new Icon(Icons.arrow_right),
                onTap: () {
                  print('pressed');
                },
              ),
              new Divider(),
              new ListTile(
                title: new Text('Get Location'),
                trailing: new Icon(Icons.arrow_right),
                onTap: () {
                  getLocation();
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

  getPermission() async {
    final GeolocationResult result =
        await Geolocation.requestLocationPermission(const LocationPermission(
            android: LocationPermissionAndroid.fine,
            ios: LocationPermissionIOS.always));
    return result;
  }
 
  getLocation() async {
    LocationResult result = await Geolocation.lastKnownLocation();
      print("Last known");
      print(result.location.latitude);
      print(result.location.longitude.toString());
    
  }

}