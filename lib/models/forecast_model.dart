import 'package:blue_sky/models/alerts_model.dart';
import 'package:blue_sky/models/currently_model.dart';
import 'package:blue_sky/models/daily_model.dart';
import 'package:blue_sky/models/flags_model.dart';
import 'package:blue_sky/models/hourly_model.dart';
import 'package:blue_sky/models/minutely_model.dart';

class Forecast {
  double latitude;
  double longitude;
  String timezone;
  Currently currently;
  Minutely minutely;
  Hourly hourly;
  Daily daily;
  List <Alerts> alerts;
  Flags flags;
  int offset;

  Forecast({
    this.latitude,
    this.longitude,
    this.timezone,
    this.currently,
    this.minutely,
    this.hourly,
    this.daily,
    this.alerts,
    this.flags,
    this.offset
  });

  factory Forecast.fromJson(Map <String, dynamic> json) {
    return Forecast(
      latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
      longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
      timezone: json["timezone"] == null ? null : json["timezone"],
      currently: json["currently"] == null ? null : Currently.fromJson(json["currently"]),
      //minutely: json["minutely"] == null ? null : Minutely.fromJson(json["minutely"]),
      //hourly: json["hourly"] == null ? null : Hourly.fromJson(json["hourly"]),
      //daily: json["daily"] == null ? null : Daily.fromJson(json["daily"]),
      //flags: json["flags"] == null ? null : Flags.fromJson(json["flags"]),
      //offset: json["offset"] == null ? null : json["offset"]
      // if (json['alerts'] != null) {
      //   alerts = new List <Alerts> ();
      //   json['alerts'].forEach((v) {
      //     alerts.add(new Alerts.fromJson(v));
      //   });
      // }
    );
  }

  Map < String, dynamic > toJson() {
    final Map <String, dynamic> data = new Map <String, dynamic> ();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['timezone'] = this.timezone;

    if (this.currently != null) {
      data['currently'] = this.currently.toJson();
    }

    if (this.minutely != null) {
      data['minutely'] = this.minutely.toJson();
    }

    if (this.hourly != null) {
      data['hourly'] = this.hourly.toJson();
    }

    // if (this.daily != null) {
    //   data['daily'] = this.daily.toJson();
    // }

    if (this.alerts != null) {
      data['alerts'] = this.alerts.map((v) => v.toJson()).toList();
    }

    if (this.flags != null) {
      data['flags'] = this.flags.toJson();
    }

    data['offset'] = this.offset;

    return data;
  }
}