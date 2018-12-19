import 'package:blue_sky/models/data_model.dart';

class Minutely {
  String summary;
  String icon;
  List <Data> data;

  Minutely({
    this.summary,
    this.icon,
    this.data
  });

  Minutely.fromJson(Map <String, dynamic> json) {
    summary = json['summary'];
    icon = json['icon'];

    if (json['data'] != null) {
      data = new List <Data> ();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }

  }

  Map <String, dynamic> toJson() {
    final Map <String, dynamic> data = new Map <String, dynamic> ();
    data['summary'] = this.summary;
    data['icon'] = this.icon;

    // if (this.data != null) {
    //   data['data'] = this.data.map((v) => v.toJson()).toList();
    // }

    return data;
  }
}