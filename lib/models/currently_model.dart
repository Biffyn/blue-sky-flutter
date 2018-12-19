import 'package:intl/intl.dart';

class Currently {
  String time;
  String date;
  String summary;
  String icon;
  int nearestStormDistance;
  int nearestStormBearing;
  double precipIntensity;
  double precipProbability;
  double temperature;
  double apparentTemperature;
  double dewPoint;
  double humidity;
  double pressure;
  double windSpeed;
  double windGust;
  int windBearing;
  double cloudCover;
  int uvIndex;
  double visibility;
  double ozone;
  String precipType;
  String imageLink;

  Currently({
    this.time,
    this.date,
    this.summary,
    this.icon,
    this.nearestStormDistance,
    this.nearestStormBearing,
    this.precipIntensity,
    this.precipProbability,
    this.temperature,
    this.apparentTemperature,
    this.dewPoint,
    this.humidity,
    this.pressure,
    this.windSpeed,
    this.windGust,
    this.windBearing,
    this.cloudCover,
    this.uvIndex,
    this.visibility,
    this.ozone,
    this.precipType,
    this.imageLink
  });

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

  static _formatPercentage(value) {
    var percent = 0.0;

    if (value == 0) {
      value = 0.0;
    }
    
    if (value != null) {
      percent = value * 100;
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

 factory Currently.fromJson(Map<String, dynamic> json) {
   return Currently(
        time: json["time"] == null ? null : _formatTime(json['time'].toInt()),
        date: json["time"] == null ? null : _formatDate(json['time'].toInt()),
        imageLink: json["icon"] == null ? null : _formatImageLink(json['icon']),
        summary: json["summary"] == null ? null : json["summary"],
        icon: json["icon"] == null ? null : json["icon"],
        nearestStormDistance: json["nearestStormDistance"] == null ? null : json["nearestStormDistance"],
        nearestStormBearing: json["nearestStormBearing"] == null ? null : json["nearestStormBearing"],
        precipIntensity: json["precipIntensity"] == null ? null : _formatPercentage(json['precipIntensity']).toDouble(),
        precipProbability: json["precipProbability"] == null ? null : _formatPercentage(json['precipProbability']).toDouble(),
        temperature: json["temperature"] == null ? null : json["temperature"].toDouble(),
        apparentTemperature: json["apparentTemperature"] == null ? null : json["apparentTemperature"].toDouble(),
        dewPoint: json["dewPoint"] == null ? null : json["dewPoint"].toDouble(),
        humidity: json["humidity"] == null ? null : json["humidity"].toDouble(),
        pressure: json["pressure"] == null ? null : json["pressure"].toDouble(),
        windSpeed: json["windSpeed"] == null ? null : json["windSpeed"].toDouble(),
        windGust: json["windGust"] == null ? null : json["windGust"].toDouble(),
        windBearing: json["windBearing"] == null ? null : json["windBearing"],
        cloudCover: json["cloudCover"] == null ? null : _formatPercentage(json['cloudCover']).toDouble(),
        uvIndex: json["uvIndex"] == null ? null : json["uvIndex"],
        visibility: json["visibility"] == null ? null : json["visibility"].toDouble(),
        ozone: json["ozone"] == null ? null : json["ozone"].toDouble(),
        precipType: json["precipType"] == null ? null : json["precipType"]
   );
 } 

    Map<String, dynamic> toJson() => {
        "time": time == null ? null : time,
        "summary": summary == null ? null : summary,
        "icon": icon == null ? null : icon,
        "nearestStormDistance": nearestStormDistance == null ? null : nearestStormDistance,
        "nearestStormBearing": nearestStormBearing == null ? null : nearestStormBearing,
        "precipIntensity": precipIntensity == null ? null : precipIntensity,
        "precipProbability": precipProbability == null ? null : precipProbability,
        "temperature": temperature == null ? null : temperature,
        "apparentTemperature": apparentTemperature == null ? null : apparentTemperature,
        "dewPoint": dewPoint == null ? null : dewPoint,
        "humidity": humidity == null ? null : humidity,
        "pressure": pressure == null ? null : pressure,
        "windSpeed": windSpeed == null ? null : windSpeed,
        "windGust": windGust == null ? null : windGust,
        "windBearing": windBearing == null ? null : windBearing,
        "cloudCover": cloudCover == null ? null : cloudCover,
        "uvIndex": uvIndex == null ? null : uvIndex,
        "visibility": visibility == null ? null : visibility,
        "ozone": ozone == null ? null : ozone,
        "precipType": precipType == null ? null : precipType,
    };
}