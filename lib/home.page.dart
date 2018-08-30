import 'dart:async';
import 'dart:convert';

import 'package:blue_sky/models/current_forecast.dart';
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
  LocationData _locationData;
  Current _currentForecast;
  PageController _pageController;
  int _page = 0;

  bool isBusy = false;

  final PublishSubject subject = PublishSubject<String>();

  @override
  void initState() {
    isBusy = true;
    super.initState();
    _initialize();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    subject.close();
    super.dispose();
    _pageController.dispose();
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  _initialize() async {
    final location = await _getCoords();
    final result = location;

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

    getForecast(result.latitude.toString(), result.longitude.toString())
        .then((current) {
      setState(() {
        _currentForecast = current;
      });
    });
  }

  Future<Position> _getCoords() async {
    Position position = await Geolocator().getLastKnownPosition(LocationAccuracy.high);
    return position;
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
    var url =
        'https://us-central1-blue-sky-bfafb.cloudfunctions.net/darkSkyProxy?latitude=${lat.toString()}&longitude=${lng.toString()}';
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

    final appBar = AppBar(
      title: Text(_locationData.suburb + ', ' + _locationData.city),
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
    );

    final drawer = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
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
                MaterialPageRoute(builder: (context) => MyLocationsPage()),
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

    final pages = PageView(
      children: [
        CurrentForecast(currentForecastObj: _currentForecast),
        HourlyForecast(),
        DailyForecast(),
        RadarPage(),
      ],
      controller: _pageController,
      onPageChanged: onPageChanged);

    final nav = BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.umbrella), 
          title: Text("Summary")
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.clock),
          title: Text("Hourly")
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.calendarAlt), 
          title: Text("Daily")
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.map),
          title: Text("Radar")
        )
      ],
      onTap: navigationTapped,
      currentIndex: _page,
      type: BottomNavigationBarType.fixed,
    );

    return new Scaffold(
        appBar: appBar, 
        drawer: drawer, 
        body: pages, 
        bottomNavigationBar: nav);
  }
}
