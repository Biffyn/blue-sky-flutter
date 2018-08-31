class Current extends Object {

  final int id;
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


  Current({
    
    this.id,
    this.summary,
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
  });

  Current.fromJson(Map jsonMap)
    :
    summary = jsonMap['summary'],
    icon = jsonMap['icon'],
    precipIntensity = jsonMap['precipIntensity'].toDouble(),
    precipProbability = jsonMap['precipProbability'].toDouble(),
    temperature = jsonMap['temperature'].toDouble(),
    apparentTemperature = jsonMap['apparentTemperature'].toDouble(),
    uvIndex = jsonMap['uvIndex'].toInt();

  //factory Current.fromJson(Map<String, dynamic> json)

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
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

