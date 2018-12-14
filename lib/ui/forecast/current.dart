import 'package:blue_sky/models/current_forecast.dart';
import 'package:blue_sky/models/location_data.dart';
import 'package:blue_sky/ui/cards/daily_card.dart';
import 'package:blue_sky/ui/cards/outlook_card.dart';
import 'package:blue_sky/ui/locations/my_locations.dart';
import 'package:blue_sky/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final primaryColor =
  const Color(0xFF38B6FF);

class CurrentForecast extends StatefulWidget {
  final Current currentForecastObj;
  final locationText;

  CurrentForecast({
    this.currentForecastObj,
    this.locationText
  });
  @override
  _CurrentForecastState createState() => new _CurrentForecastState();
}

class _CurrentForecastState extends State < CurrentForecast > {
  @override

  Widget build(BuildContext context) {
    if (widget.currentForecastObj == null) {
      return new Container();
    }

    return new CustomScrollView(
      slivers: < Widget > [
        new SliverAppBar(
          backgroundColor: $Colors.primaryColor,
          actions: < Widget > [
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
          expandedHeight: 400.0,
          title: new Text(widget.locationText),
          floating: false,
          pinned: true,
          flexibleSpace: new FlexibleSpaceBar(
            background: new Container(
              padding: EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 20.0),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage(widget.currentForecastObj.imageLink),
                  fit: BoxFit.cover,
                )
              ),

              child: new Column(
                children: < Widget > [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: < Widget > [
                      new Text('Now',
                        style: new TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                        )
                      ),
                      new Text(widget.currentForecastObj.time,
                        style: new TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                        )
                      ),

                    ],
                  ),
                  new Padding(
                    padding: new EdgeInsets.fromLTRB(7.0, 5.0, 0.0, 0.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: < Widget > [
                        new Text(widget.currentForecastObj.temperature.toStringAsFixed(0) + '\u00B0',
                          style: new TextStyle(
                            shadows: < Shadow > [
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Colors.black12,
                              ),
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 5.0,
                                color: Colors.black12,
                              ),
                            ],
                            color: Colors.white,
                            fontSize: 70.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.fromLTRB(7.0, 0.0, 0.0, 20.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: < Widget > [
                        new Text(widget.currentForecastObj.summary,
                          style: new TextStyle(
                            shadows: < Shadow > [
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Colors.black12,
                              ),
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 5.0,
                                color: Colors.black12,
                              ),
                            ],
                            color: Colors.white,
                            fontSize: 28.0,
                          ),
                        ),
                      ]
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.fromLTRB(7.0, 0.0, 0.0, 0.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: < Widget > [
                        new Text('Feels Like: ' + widget.currentForecastObj.apparentTemperature.toStringAsFixed(0) + '\u00B0',
                          style: new TextStyle(
                            shadows: < Shadow > [
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Colors.black12,
                              ),
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 5.0,
                                color: Colors.black12,
                              ),
                            ],
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ]
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.fromLTRB(7.0, 0.0, 0.0, 0.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: < Widget > [
                        new Text('Chance of rain: ' + widget.currentForecastObj.precipProbability.toStringAsFixed(0) + '%',
                          style: new TextStyle(
                            shadows: < Shadow > [
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Colors.black12,
                              ),
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 5.0,
                                color: Colors.black12,
                              ),
                            ],
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ]
                    ),
                  ),
                ]
              ),
            ),
          )
        ),

        new SliverPadding(
          padding: const EdgeInsets.all(10.0),
            sliver: new SliverFixedExtentList(

              itemExtent: 200.0,
              delegate: new SliverChildBuilderDelegate(

                (BuildContext context, int index) => new OutlookCard(),
                childCount: 1
              ),
            ),
        ),
        new SliverPadding(
          padding: const EdgeInsets.all(10.0),
            sliver: new SliverFixedExtentList(

              itemExtent: 200.0,
              delegate: new SliverChildBuilderDelegate(

                (BuildContext context, int index) => new DailyCard(),
                childCount: 1
              ),
            ),
        ),
        new SliverPadding(
          padding: const EdgeInsets.all(10.0),
            sliver: new SliverFixedExtentList(

              itemExtent: 200.0,
              delegate: new SliverChildBuilderDelegate(

                (BuildContext context, int index) => new OutlookCard(),
                childCount: 1
              ),
            ),
        ),
        new SliverPadding(
          padding: const EdgeInsets.all(10.0),
            sliver: new SliverFixedExtentList(

              itemExtent: 200.0,
              delegate: new SliverChildBuilderDelegate(

                (BuildContext context, int index) => new DailyCard(),
                childCount: 1
              ),
            ),
        ),
      ],

    );

  }

}