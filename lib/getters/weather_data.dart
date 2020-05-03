import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/models/error_data_model.dart';
import 'package:weather/models/weather_data_model.dart';
import 'dart:convert';
import 'package:location/location.dart';

Future getWeatherData() async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      throw Exception("We're fucked up");
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      throw Exception("We're fucked upopp");
    }
  }
// Future<Widget> isLogged() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String result = prefs.getString('apiKey');
//   if(result != null && result != ''){
//     return MainScreen();
//     // return false;
//   }else{
//     return GetApiKey();
//     // return true;
//   }
// }
  _locationData = await location.getLocation();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _result = prefs.getString('apiKey');

  // final String _apikey = "Eo8uP8XylsMsqt6VBwtM6deKaWRkPi7g";
  final String _apikey = _result;
  final String lat = _locationData.latitude.toString();
  final String lng = _locationData.longitude.toString();

  print("Lat: $lat, lng: $lng");
  // final String lat = "49.886365";
  // final String lng = "19.479579";
  final String urlReq =
      'https://airapi.airly.eu/v2/measurements/point?lat=$lat&lng=$lng';

  final response = await http.get(urlReq, headers: {
    'Accept': 'application/json',
    'apikey': _apikey,
    'Accept-Language': 'pl',
  });
  // final response =
  //     '{"current":{"fromDateTime":"2020-04-28T14:03:54.275Z","tillDateTime":"2020-04-28T15:03:54.275Z","values":[{"name":"PM1","value":4.83},{"name":"PM25","value":6.2},{"name":"PM10","value":8.06},{"name":"PRESSURE","value":1005.07},{"name":"HUMIDITY","value":33.83},{"name":"TEMPERATURE","value":22.47}],"indexes":[{"name":"AIRLY_CAQI","value":10.33,"level":"VERY_LOW","description":"Wspaniałe powietrze!","advice":"Trwaj zieleń, trwaj!","color":"#6BC926"}],"standards":[{"name":"WHO","pollutant":"PM25","limit":25.0,"percent":24.79,"averaging":"24h"},{"name":"WHO","pollutant":"PM10","limit":50.0,"percent":16.12,"averaging":"24h"}]}}';

  if (response.statusCode == 200) {
    print("Pozostałe:");
    print(response.headers['x-ratelimit-remaining-day']);

    print(response.headers.toString());
    WeatherData weatherData = new WeatherData.fromJson(
        json.decode(response.body), response.headers, response.statusCode);
    return weatherData;
  } else {
    ErrorData errorData = new ErrorData.fromJson(json.decode(response.body), response.statusCode);
    return errorData;
  }
  // WeatherData weatherData = new WeatherData.fromJson(json.decode(response));
  // await Future.delayed(Duration(seconds: 1));
  // return weatherData;
}
