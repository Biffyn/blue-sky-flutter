import 'package:intl/intl.dart';

class Data {
  String time;
  String date;
  String summary;
  String icon;
  String imageLink;
  int sunriseTime;
  int sunsetTime;
  double moonPhase;
  double precipIntensity;
  double precipIntensityMax;
  int precipIntensityMaxTime;
  double precipProbability;
  String precipType;
  double temperatureHigh;
  int temperatureHighTime;
  double temperatureLow;
  int temperatureLowTime;
  double apparentTemperatureHigh;
  int apparentTemperatureHighTime;
  double apparentTemperatureLow;
  int apparentTemperatureLowTime;
  double dewPoint;
  double humidity;
  double pressure;
  double windSpeed;
  double windGust;
  int windGustTime;
  int windBearing;
  double cloudCover;
  int uvIndex;
  int uvIndexTime;
  double visibility;
  double ozone;
  double temperatureMin;
  int temperatureMinTime;
  double temperatureMax;
  int temperatureMaxTime;
  double apparentTemperatureMin;
  int apparentTemperatureMinTime;
  double apparentTemperatureMax;
  int apparentTemperatureMaxTime;

  Data({
    this.time,
    this.date,
    this.imageLink,
    this.summary,
    this.icon,
    this.sunriseTime,
    this.sunsetTime,
    this.moonPhase,
    this.precipIntensity,
    this.precipIntensityMax,
    this.precipIntensityMaxTime,
    this.precipProbability,
    this.precipType,
    this.temperatureHigh,
    this.temperatureHighTime,
    this.temperatureLow,
    this.temperatureLowTime,
    this.apparentTemperatureHigh,
    this.apparentTemperatureHighTime,
    this.apparentTemperatureLow,
    this.apparentTemperatureLowTime,
    this.dewPoint,
    this.humidity,
    this.pressure,
    this.windSpeed,
    this.windGust,
    this.windGustTime,
    this.windBearing,
    this.cloudCover,
    this.uvIndex,
    this.uvIndexTime,
    this.visibility,
    this.ozone,
    this.temperatureMin,
    this.temperatureMinTime,
    this.temperatureMax,
    this.temperatureMaxTime,
    this.apparentTemperatureMin,
    this.apparentTemperatureMinTime,
    this.apparentTemperatureMax,
    this.apparentTemperatureMaxTime,
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

  factory Data.fromJson(Map < String, dynamic > json) {
    return Data(
      time: json["time"] == null ? null : _formatTime(json['time'].toInt()),
      date: json["time"] == null ? null : _formatDate(json['time'].toInt()),
      imageLink: json["icon"] == null ? null : _formatImageLink(json['icon']),
      summary: json["summary"] == null ? null : json["summary"],
      icon: json["icon"] == null ? null : json["icon"],
      sunriseTime: json["sunriseTime"] == null ? null : json["sunriseTime"],
      sunsetTime: json["sunsetTime"] == null ? null : json["sunsetTime"],
      moonPhase: json["moonPhase"] == null ? null : json["moonPhase"].toDouble(),
      precipIntensity: json["precipIntensity"] == null ? null : json["precipIntensity"].toDouble(),
      precipIntensityMax: json["precipIntensityMax"] == null ? null : json["precipIntensityMax"].toDouble(),
      precipIntensityMaxTime: json["precipIntensityMaxTime"] == null ? null : json["precipIntensityMaxTime"],
      precipProbability: json["precipProbability"] == null ? null : _formatPercentage(json['precipProbability']).toDouble(),
      precipType: json["precipType"] == null ? null : json["precipType"],
      temperatureHigh: json["temperatureHigh"] == null ? null : json["temperatureHigh"].toDouble(),
      temperatureHighTime: json["temperatureHighTime"] == null ? null : json["temperatureHighTime"],
      temperatureLow: json["temperatureLow"] == null ? null : json["temperatureLow"].toDouble(),
      temperatureLowTime: json["temperatureLowTime"] == null ? null : json["temperatureLowTime"],
      apparentTemperatureHigh: json["apparentTemperatureHigh"] == null ? null : json["apparentTemperatureHigh"].toDouble(),
      apparentTemperatureHighTime: json["apparentTemperatureHighTime"] == null ? null : json["apparentTemperatureHighTime"],
      apparentTemperatureLow: json["apparentTemperatureLow"] == null ? null : json["apparentTemperatureLow"].toDouble(),
      apparentTemperatureLowTime: json["apparentTemperatureLowTime"] == null ? null : json["apparentTemperatureLowTime"],
      dewPoint: json["dewPoint"] == null ? null : json["dewPoint"].toDouble(),
      humidity: json["humidity"] == null ? null : json["humidity"].toDouble(),
      pressure: json["pressure"] == null ? null : json["pressure"].toDouble(),
      windSpeed: json["windSpeed"] == null ? null : json["windSpeed"].toDouble(),
      windGust: json["windGust"] == null ? null : json["windGust"].toDouble(),
      windGustTime: json["windGustTime"] == null ? null : json["windGustTime"],
      windBearing: json["windBearing"] == null ? null : json["windBearing"],
      cloudCover: json["cloudCover"] == null ? null : _formatPercentage(json['cloudCover']).toDouble(),
      uvIndex: json["uvIndex"] == null ? null : json["uvIndex"],
      uvIndexTime: json["uvIndexTime"] == null ? null : json["uvIndexTime"],
      visibility: json["visibility"] == null ? null : json["visibility"].toDouble(),
      ozone: json["ozone"] == null ? null : json["ozone"].toDouble(),
      temperatureMin: json["temperatureMin"] == null ? null : json["temperatureMin"].toDouble(),
      temperatureMinTime: json["temperatureMinTime"] == null ? null : json["temperatureMinTime"],
      temperatureMax: json["temperatureMax"] == null ? null : json["temperatureMax"].toDouble(),
      temperatureMaxTime: json["temperatureMaxTime"] == null ? null : json["temperatureMaxTime"],
      apparentTemperatureMin: json["apparentTemperatureMin"] == null ? null : json["apparentTemperatureMin"].toDouble(),
      apparentTemperatureMinTime: json["apparentTemperatureMinTime"] == null ? null : json["apparentTemperatureMinTime"],
      apparentTemperatureMax: json["apparentTemperatureMax"] == null ? null : json["apparentTemperatureMax"].toDouble(),
      apparentTemperatureMaxTime: json["apparentTemperatureMaxTime"] == null ? null : json["apparentTemperatureMaxTime"],
    );
  }

  // Map < String, dynamic > toJson() {
  //   final Map < String, dynamic > data = new Map < String, dynamic > ();
  //   data['time'] = this.time;
  //   data['summary'] = this.summary;
  //   data['icon'] = this.icon;
  //   data['precipIntensity'] = this.precipIntensity;
  //   data['precipProbability'] = this.precipProbability;
  //   data['precipType'] = this.precipType;
  //   data['temperature'] = this.temperature;
  //   data['apparentTemperature'] = this.apparentTemperature;
  //   data['dewPoint'] = this.dewPoint;
  //   data['humidity'] = this.humidity;
  //   data['pressure'] = this.pressure;
  //   data['windSpeed'] = this.windSpeed;
  //   data['windGust'] = this.windGust;
  //   data['windBearing'] = this.windBearing;
  //   data['cloudCover'] = this.cloudCover;
  //   data['uvIndex'] = this.uvIndex;
  //   data['visibility'] = this.visibility;
  //   data['ozone'] = this.ozone;
  //   return data;
  // }
}