class WeatherData {
  final String time; //time of measurement

  final String name; //name of the index (CAQI or PIJP)
  final String description; // translated text of the description of the index level
  final double value; // numerical value of the calculated index
  final String level; // level of the index
  final String advice; 
  final String color; // color representing index level

  final double pm1;
  final double pm25;
  final double pm10;
  final int pressure;
  final int humidity;
  final int temperature;

  WeatherData({
    this.name,
    this.description,
    this.value,
    this.level,
    this.advice,
    this.color,
    this.pm1,
    this.pm25,
    this.pm10,
    this.pressure,
    this.humidity,
    this.temperature,
    this.time,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      name: json['current']['indexes'][0]["name"],
      description: json['current']['indexes'][0]["description"],
      value: json['current']['indexes'][0]["value"],
      level: json['current']['indexes'][0]["level"],
      advice: json['current']['indexes'][0]["advice"],
      color: json['current']['indexes'][0]["color"],
      pm1: json['current']['values'][0]["value"],
      pm25: json['current']['values'][1]["value"],
      pm10: json['current']['values'][2]["value"],
      pressure: json['current']['values'][3]["value"].round(),
      humidity: json['current']['values'][4]["value"].round(),
      temperature: json['current']['values'][5]["value"].round(),
      time: json['current']['tillDateTime'],
    );
  }
}
