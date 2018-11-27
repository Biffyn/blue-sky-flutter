import 'package:blue_sky/models/current_forecast.dart';
import 'package:blue_sky/models/location_data.dart';
import 'package:blue_sky/ui/locations/my_locations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
 
class CurrentForecast extends StatefulWidget  {
 final Current currentForecastObj;
 final LocationData locationDataObj;
 
   CurrentForecast({
     this.currentForecastObj,
     this.locationDataObj
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

  return new CustomScrollView(
    slivers: <Widget>[
      new SliverAppBar(
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
        expandedHeight: 250.0,
        title: new Text(widget.locationDataObj.suburb + ', ' + widget.locationDataObj.city),
        floating: false,
        pinned: true,
        flexibleSpace: new FlexibleSpaceBar(
          background: Container(
            padding: EdgeInsets.fromLTRB(20.0, 70.0, 0.0, 0.0),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/bg_clouds.jpg'),
                fit: BoxFit.cover,
              )
            ),

            child: new Column(
              children: <Widget>[

                new Align(
                  alignment: Alignment.topRight,
                  child: new Text( widget.currentForecastObj.time,
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),

                new Align(
                alignment: Alignment.topLeft,
                child: new Text( widget.currentForecastObj.temperature.toStringAsFixed(0) + '\u00B0',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                    ),
                  ),
                ),

                new Align(
                  alignment: Alignment.bottomLeft,
                  child: new Text( widget.currentForecastObj.summary,
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
                ), 
              ]
            ),
          ),
        )
      ),
      new SliverFixedExtentList(
            itemExtent: 50.0,
            // delegate: SliverChildListDelegate([
            //   Text('1'),
            //   Text('2'),
            //   Text('3'),
            //   Text('4'),
            // ]),

            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.indigo[100 * (index % 9)],
                child: Text('List Item: $index'),
              );
            }),
          )
    ],
    
  );

  }
}