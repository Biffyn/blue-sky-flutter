import 'package:flutter/material.dart';

class DailyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final baseTextStyle = const TextStyle(
      fontFamily: 'Poppins'
    );

    final regularTextStyle = baseTextStyle.copyWith(
      color: const Color(0xffb6b2df),
      fontSize: 9.0,
      fontWeight: FontWeight.w400
    );

    final subHeaderTextStyle = regularTextStyle.copyWith(
      fontSize: 12.0
    );

    final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.w600
    );

    Widget _planetValue({String value, String image}) {
      return new Row(
        children: <Widget>[
          new Image.asset(image, height: 12.0),
          new Container(width: 8.0),
          new Text(value, style: regularTextStyle),
        ]
      );
    }

    final planetCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text('Daily Forecast', style: headerTextStyle),
          new Container(height: 10.0),
          new Text('Mostly cloudy until tomorrow morning.', style: subHeaderTextStyle),
          new Container(
            margin: new EdgeInsets.symmetric(vertical: 8.0),
            height: 2.0,
            width: 58.0,
            color: new Color(0xff00c6ff)
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: _planetValue(
                  value: 'Location',
                  image: 'assets/img/ic_distance.png')

              ),
              new Expanded(
                child: _planetValue(
                  value: 'Chance of rain',
                  image: 'assets/img/ic_gravity.png')
              )
            ],
          ),
        ],
      ),
    );

    final planetCard = new Container(
      child: planetCardContent,
      height: 200.0,
      decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );

    return new Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 14.0,
      ),
      child: new Stack(
        children: <Widget>[
          planetCard,
        ],
      )
    );
  }
}