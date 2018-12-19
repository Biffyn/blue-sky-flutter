class Alerts {
  String title;
  List <String> regions;
  String severity;
  int time;
  int expires;
  String description;
  String uri;

  Alerts({
    this.title,
    this.regions,
    this.severity,
    this.time,
    this.expires,
    this.description,
    this.uri
  });

  Alerts.fromJson(Map <String, dynamic> json) {
    title = json['title'];
    regions = json['regions'].cast <String> ();
    severity = json['severity'];
    time = json['time'];
    expires = json['expires'];
    description = json['description'];
    uri = json['uri'];
  }

  Map <String, dynamic> toJson() {
    final Map <String, dynamic> data = new Map <String, dynamic> ();
    data['title'] = this.title;
    data['regions'] = this.regions;
    data['severity'] = this.severity;
    data['time'] = this.time;
    data['expires'] = this.expires;
    data['description'] = this.description;
    data['uri'] = this.uri;
    return data;
  }
}