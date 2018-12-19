class Flags {
  List <String> sources;
  String meteoalarmLicense;
  double nearestStation;
  String units;

  Flags({
    this.sources,
    this.meteoalarmLicense,
    this.nearestStation,
    this.units
  });

  Flags.fromJson(Map <String, dynamic> json) {
    sources = json['sources'].cast <String> ();
    meteoalarmLicense = json['meteoalarm-license'];
    nearestStation = json['nearest-station'];
    units = json['units'];
  }

  Map <String, dynamic> toJson() {
    final Map <String, dynamic> data = new Map <String, dynamic> ();
    data['sources'] = this.sources;
    data['meteoalarm-license'] = this.meteoalarmLicense;
    data['nearest-station'] = this.nearestStation;
    data['units'] = this.units;
    return data;
  }
}