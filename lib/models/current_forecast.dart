import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Current extends Object {

  final DateTime time;
  final String summary;
  final String icon;
  final double precipIntensity;
  final double precipProbability;
  final double temperature;
  final double apparentTemperature;
  final double dewPoint;
  final double humidity;
  final double pressure;
  final double windSpeed;
  final double windBearing;
  final double cloudCover;
  final int uvIndex;
  final double visibility;
  final double ozone;


  Current({
    this.time,
    this.summary,
    this.icon,
    this.precipIntensity,
    this.precipProbability,
    this.temperature,
    this.apparentTemperature,
    this.dewPoint,
    this.humidity,
    this.pressure,
    this.windSpeed,
    this.windBearing,
    this.cloudCover,
    this.uvIndex,
    this.visibility,
    this.ozone
  });

  //factory Current.fromJson(Map<String, dynamic> json)

}