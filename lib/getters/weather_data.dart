import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/models/error_data_model.dart';
import 'package:weather/models/weather_data_model.dart';
import 'dart:convert';
import 'package:location/location.dart';

Future getWeatherData() async {
  String urlReq;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> stationInfo = prefs.getStringList('station');
  String _result = prefs.getString('apiKey');
  String city;
  final String _apikey =
      _result.trim().replaceAll(new RegExp('[^\u0001-\u007F]'), '');
  if (_apikey == '0000TEST0000') {
    final response =
        '{"current":{"fromDateTime":"2020-06-13T17:28:15.316Z","tillDateTime":"2020-06-13T18:28:15.316Z","values":[{"name":"PM1","value":6.63},{"name":"PM25","value":8.86},{"name":"PM10","value":11.72},{"name":"PRESSURE","value":1009.98},{"name":"HUMIDITY","value":69.19},{"name":"TEMPERATURE","value":25.31}],"indexes":[{"name":"AIRLY_CAQI","value":14.76,"level":"VERY_LOW","description":"Wspaniałe powietrze!","advice":"Śmiało wietrz mieszkanie!","color":"#6BC926"}],"standards":[{"name":"WHO","pollutant":"PM25","limit":25.0,"percent":35.43,"averaging":"24h"},{"name":"WHO","pollutant":"PM10","limit":50.0,"percent":23.44,"averaging":"24h"}]}}';
    final headers =
        '{"x-ratelimit-remaining-minute": "49", "x-ratelimit-limit-minute": "50","x-ratelimit-remaining-day": "910","x-ratelimit-limit-day": "1000"}';
    final statusCode = 200;
    WeatherData weatherData = new WeatherData.fromJson(
        json.decode(response), json.decode(headers), statusCode, 'Warszawa');
    await Future.delayed(Duration(seconds: 2));
    return weatherData;
  } else {
    if (stationInfo != null) {
      String stationId = stationInfo[0];
      city = stationInfo[1];
      urlReq =
          'https://airapi.airly.eu/v2/measurements/installation?installationId=$stationId';
    } else {
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
      _locationData = await location.getLocation();

      final String lat = _locationData.latitude.toString();
      final String lng = _locationData.longitude.toString();

      urlReq =
          'https://airapi.airly.eu/v2/measurements/point?lat=$lat&lng=$lng';
    }
    var response;
    try {
      response = await http.get(urlReq, headers: {
        'Accept': 'application/json',
        'apikey': _apikey,
        'Accept-Language': 'pl',
      });
    } catch (e) {
      // throw Exception();
      return new ErrorData(
        statusCode: e.osError.errorCode,
        errorMessage: e.message,
      );
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = json.decode(response.body);

      if (decodedResponse['current']['indexes'][0]['value'] == null &&
          decodedResponse['current']['indexes'][0]['level'] == 'UNKNOWN') {
        ErrorData errorData = new ErrorData(
            statusCode: 404,
            errorMessage:
                "W Twojej okolicy nie ma jeszcze naszych sensorów. Wejdź w ustawienia i wybierz jeden z dostępnych niedaleko Ciebie.");
        return errorData;
      }

      WeatherData weatherData = new WeatherData.fromJson(
          decodedResponse, response.headers, response.statusCode, city);
      return weatherData;
    } else {
      ErrorData errorData = new ErrorData.fromJson(
          json.decode(response.body), response.statusCode);
      return errorData;
    }
  }
}
