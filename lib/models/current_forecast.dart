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
  final String imageLink;

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
      this.time,
      this.imageLink});

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

  static _formatPrecipProbability(precipProbability) {
    var percent = 0.0;

    if (precipProbability == 0) {
      precipProbability = 0.0;
    }
    
    if (precipProbability != null) {
      percent = precipProbability * 100;
    }
    percent.toInt();
    return percent.round();
  }

static _formatImageLink(String icon) {
  String formattedLink = '';

  switch (icon) {
    case 'clear-day':
      formattedLink = 'assets/img/christmas-tree.webp';
      break;

    case 'clear-night':
      formattedLink = 'assets/img/abduction.webp';
      break;

    case 'rain':
      formattedLink = 'assets/img/windows.webp';
      break;

    case 'snow':
      formattedLink = 'assets/img/snowman.webp';
      break;

    case 'sleet':
      formattedLink = 'assets/img/snowman.webp';
      break;

    case 'wind':
      formattedLink = 'assets/img/windows.webp';
      break;

    case 'fog':
      formattedLink = 'assets/img/windows.webp';
      break;

    case 'cloudy':
      formattedLink = 'assets/img/christmas-tree.webp';
      break;

    case 'partly-cloudy-day':
      formattedLink = 'assets/img/christmas-tree.webp';
      break;

    case 'partly-cloudy-night':
      formattedLink = 'assets/img/abduction.webp';
      break;

    default:
      formattedLink = 'assets/img/christmas-tree.webp';
  }

  return formattedLink;

}

  Current.fromJson(Map jsonMap)
      : summary = jsonMap['summary'],
        icon = jsonMap['icon'],
        precipIntensity = jsonMap['precipIntensity'].toDouble(),
        precipProbability = _formatPrecipProbability(jsonMap['precipProbability']).toDouble(),
        temperature = jsonMap['temperature'].toDouble(),
        apparentTemperature = jsonMap['apparentTemperature'].toDouble(),
        uvIndex = jsonMap['uvIndex'].toInt(),
        date = _formatDate(jsonMap['time'].toInt()),
        time = _formatTime(jsonMap['time'].toInt()),
        imageLink = _formatImageLink(jsonMap['icon']);

  //factory Current.fromJson(Map<String, dynamic> json)

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    //map['id'] = id;
    map['summary'] = summary;
    map['icon'] = icon;
    map['precipIntensity'] = precipIntensity;
    map['precipProbability'] = precipProbability;
    map['temperature'] = temperature;
    map['apparentTemperature'] = apparentTemperature;
    map['uvIndex'] = uvIndex;

    return map;
  }

}

