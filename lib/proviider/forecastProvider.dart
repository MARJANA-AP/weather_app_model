import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
// import 'package:weather_app_model/services/locationAccess.dart';
import '../model/forecast_weather_model.dart';
// import '../services/location_access.dart';

class ForecastDetails with ChangeNotifier {
  ForecastWeatherModel? _forecastData;
  ForecastWeatherModel? get forecastdata => _forecastData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // LocationFetcher locationFetcher = LocationFetcher();

  Future<void> fetchForecast() async {
    // await locationFetcher.determinePosition();

    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    // final latitude = position.latitude;
    // final longitude = position.longitude;
    String baseUrl =
        // "api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=10.99&appid=5d2d4c9c28d93d15220a4336c28e26d1"
        "https://api.openweathermap.org/data/2.5/forecast?lat=lat=44.34&lon=10.99&appid=5d2d4c9c28d93d15220a4336c28e26d1&units=imperial";

    _isLoading = true;
    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      _forecastData = ForecastWeatherModel.fromJson(json.decode(response.body));
      //   String currentDate = DateTime.now().toLocal().toString().split(' ')[0];
      //   List<dynamic> currentDayForecast = _forecastData!['forecast'].where((forecast) {
      //   return forecast['dt_txt'].startsWith(currentDate);
      // }).toList();
      print(response.body);
      _isLoading = false;
      notifyListeners();
    } else {
      print("error--------------------------------------------");
    }
  }
}
