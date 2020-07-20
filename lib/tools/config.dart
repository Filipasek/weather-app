import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Creates easily accesible configuration data for things like app theme.
class ConfigData extends ChangeNotifier {
  /// Tells if the light indicating quality of the weather by color should be shown.
  bool weatherLight;
  SharedPreferences prefs;
  List<String> templateConfig = ['true', '0'];
  /// 0 is white theme, 1 is dark theme
  int themeColor;

  void changeWeatherLightBoolean(newValue) {
    weatherLight = newValue;
    List<String> oldValue = prefs.getStringList('configData') ?? templateConfig;
    oldValue[0] = newValue.toString();
    prefs.setStringList('configData', oldValue);
    notifyListeners();
  }

  void readConfigs() async {
    prefs = await SharedPreferences.getInstance();
    List<String> configData = prefs.getStringList('configData') ?? templateConfig;
    weatherLight = configData[0] == 'false' ? false : true;
    themeColor = int.parse(configData[1] ?? '0');
    notifyListeners();
  }
}
