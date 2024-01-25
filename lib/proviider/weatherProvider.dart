import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_model/model/weathermodel.dart';
// import 'package:weather_app_model/services/locationAccess.dart';

class WeatherDetails with ChangeNotifier {
  WeatherModel? _weatherData;
  WeatherModel? get weatherdata => _weatherData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // LocationFetcher locationFetcher = LocationFetcher();

  Future<void> fetchData() async {
    // await locationFetcher.determinePosition();

    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.medium);

    // print(
    //     " --------------------------------${position.latitude}___________ ${position.longitude}");

    // final latitude = position.latitude;
    // final longitude = position.longitude;

    String baseUrl =
        "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=5d2d4c9c28d93d15220a4336c28e26d1";

    _isLoading = true;
    var response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      _weatherData = weatherModelFromJson(response.body);
      print(response.body);
      _isLoading = false;
      notifyListeners();
    } else {
      print("error--------------------------------------------");
    }
  }
}
