import 'package:intl/intl.dart';

class Current extends Object {
  final String summary;
  final String icon;
  final double precipIntensity;
  final double precipProbability;
  final double temperature;
  final double apparentTemperature;
  // final double dewPoint;
  // final double humidity;
  // final double pressure;
  // final double windSpeed;
  // final double windBearing;
  // final double cloudCover;
  final int uvIndex;
  //final double visibility;
  //final double ozone;
  final String date;
  final String time;

  Current(
      {this.summary,
      this.icon,
      this.precipIntensity,
      this.precipProbability,
      this.temperature,
      this.apparentTemperature,
      //this.dewPoint,
      //this.humidity,
      //this.pressure,
      //this.windSpeed,
      //this.windBearing,
      //this.cloudCover,
      this.uvIndex,
      //this.visibility,
      //this.ozone
      this.date,
      this.time});

  static _formatDate(int date) {
    //"EEE, MMM d" Wed, Jul 10,
    final format = new DateFormat.yMMMd("en_US");
    final formattedDate = format
        .format(new DateTime.fromMillisecondsSinceEpoch(date * 1000))
        .toString();
    return formattedDate;
  }

  static _formatTime(int time) {
    final format = new DateFormat.Hm();
    final formattedDate = format
        .format(new DateTime.fromMillisecondsSinceEpoch(time * 1000))
        .toString();
    return formattedDate;
  }

  

  Current.fromJson(Map jsonMap)
      : summary = jsonMap['summary'],
        icon = jsonMap['icon'],
        precipIntensity = jsonMap['precipIntensity'].toDouble(),
        precipProbability = jsonMap['precipProbability'].toDouble(),
        temperature = jsonMap['temperature'].toDouble(),
        apparentTemperature = jsonMap['apparentTemperature'].toDouble(),
        uvIndex = jsonMap['uvIndex'].toInt(),
        date = _formatDate(jsonMap['time'].toInt()),
        time = _formatTime(jsonMap['time'].toInt());

  //factory Current.fromJson(Map<String, dynamic> json)

}
