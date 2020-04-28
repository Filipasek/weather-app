import 'package:http/http.dart' as http;
import 'package:weather/models/weather_data_model.dart';
import 'dart:convert';

Future<WeatherData> getWeatherData() async {
  final String _apikey = "Eo8uP8XylsMsqt6VBwtM6deKaWRkPi7g";
  final String lat = "49.886365";
  final String lng = "19.479579";
  final String urlReq =
      'https://airapi.airly.eu/v2/measurements/point?lat=$lat&lng=$lng';

  // final response = await http.get(
  //   urlReq,
  //   headers: {
  //     'Accept': 'application/json',
  //     'apikey': _apikey,
  //     'Accept-Language': 'pl',
  //   }
  // );
  final response =
      '{"current":{"fromDateTime":"2020-04-28T14:03:54.275Z","tillDateTime":"2020-04-28T15:03:54.275Z","values":[{"name":"PM1","value":4.83},{"name":"PM25","value":6.2},{"name":"PM10","value":8.06},{"name":"PRESSURE","value":1005.07},{"name":"HUMIDITY","value":33.83},{"name":"TEMPERATURE","value":22.47}],"indexes":[{"name":"AIRLY_CAQI","value":10.33,"level":"VERY_LOW","description":"Wspaniałe powietrze!","advice":"Trwaj zieleń, trwaj!","color":"#6BC926"}],"standards":[{"name":"WHO","pollutant":"PM25","limit":25.0,"percent":24.79,"averaging":"24h"},{"name":"WHO","pollutant":"PM10","limit":50.0,"percent":16.12,"averaging":"24h"}]}}';

  // if(response.statusCode == 200){
  //   WeatherData weatherData = new WeatherData.fromJson(json.decode(response.body));
  //   return weatherData;
  // }else{
  //   throw Exception('Failed to get data');
  // }
  WeatherData weatherData =
      new WeatherData.fromJson(json.decode(response));
  return weatherData;
}
