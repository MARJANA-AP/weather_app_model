import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qweather_icons/qweather_icons.dart';
import 'package:weather_app_model/proviider/weatherProvider.dart';
import 'package:weather_app_model/screens/foreCast.dart';

import '../widgets/weatherdata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Provider.of<WeatherDetails>(context, listen: false).fetchData();
    //Provider.of<ForecastDetails>(context, listen: false).fetchForecast();
  }

//To convert MillisecondsSinceEpoch to DateTime
  DateTime? unpackDate(dynamic k) {
    int millis = k * 1000;
    return DateTime.fromMillisecondsSinceEpoch(millis);
  }

  //convert fahrenheit to celcius
  int convertToFahrenheit(double fahrenheit) {
    return ((fahrenheit - 32) * 5 / 9).round();
  }

//format date
  String formatDate(dynamic date) {
    String formattedDate = DateFormat('E d, y').format(date);
    return formattedDate;
  }

  String formatDate2(dynamic date) {
    String formattedDate = DateFormat('hh:mm').format(date);
    return formattedDate;
  }

  DateTime timeZoneToTime(dynamic timezoneOffsetSeconds) {
    // Timezone offset from OpenWeatherMap API (in seconds)

    // Create a Duration with the given offset
    Duration offsetDuration = Duration(seconds: timezoneOffsetSeconds);

    // Get the current UTC time
    DateTime utcTime = DateTime.now().toUtc();

    // Apply the offset to get the local time
    DateTime localTime = utcTime.add(offsetDuration);
    return localTime;
  }

  // to format description
  String formatDescName(String descName) {
    List<String> words = descName.split(' ');
    for (int i = 0; i < words.length; i++) {
      words[i] =
          "${words[i][0].toUpperCase()}${words[i].substring(1).toLowerCase()}";
    }
    return words.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final weatherInfo = Provider.of<WeatherDetails>(context);
    // final forecastInfo = Provider.of<ForecastDetails>(context);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.3,
              0.5,
              0.7,
              0.9
            ],
            colors: <Color>[
              Color.fromARGB(255, 102, 103, 104),
              Color.fromARGB(255, 94, 96, 97),
              Color.fromARGB(255, 154, 156, 158),
              Color.fromARGB(184, 78, 81, 81),
              Color.fromARGB(255, 100, 101, 101),
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: weatherInfo.weatherdata == null
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                        ),
                        Center(
                          child: Text(
                            weatherInfo.weatherdata!.name,
                            style: const TextStyle(
                                // color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          formatDate2(timeZoneToTime(
                              weatherInfo.weatherdata!.timezone)),
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          formatDate(unpackDate(weatherInfo.weatherdata!.dt)),
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(172, 128, 128, 130),
                            borderRadius: BorderRadius.circular(25)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weatherInfo.weatherdata!.weather[0].description,
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 35, right: 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "${convertToFahrenheit(weatherInfo.weatherdata!.main.temp)}\u00B0",
                                          style: const TextStyle(
                                              fontSize: 60,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "${convertToFahrenheit(weatherInfo.weatherdata!.main.tempMax)}\u00B0/${convertToFahrenheit(weatherInfo.weatherdata!.main.tempMin)}\u00B0",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 130,
                                      height: 130,
                                      child: Image.network(
                                        "https://openweathermap.org/img/wn/04n@2x.png",
                                        width: 130,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 250,
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                weatherData(
                                    weatherIcon: QWeatherIcons
                                        .tag_weather_advisory2.iconData,
                                    title: 'Feels like',
                                    value:
                                        "${weatherInfo.weatherdata!.main.feelsLike}\u00B0C"),
                                weatherData(
                                  weatherIcon:
                                      QWeatherIcons.tag_low_humidity2.iconData,
                                  title: 'Humidity',
                                  value:
                                      "${weatherInfo.weatherdata!.main.humidity}%",
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                weatherData(
                                  weatherIcon: QWeatherIcons.tag_wind.iconData,
                                  title: 'Wind Speed',
                                  value:
                                      "${weatherInfo.weatherdata!.wind.speed}m\s",
                                ),
                                weatherData(
                                  weatherIcon:
                                      QWeatherIcons.tag_shower_rain.iconData,
                                  title: 'Pressure',
                                  value:
                                      "${weatherInfo.weatherdata!.main.pressure}mb",
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                weatherData(
                                  weatherIcon:
                                      QWeatherIcons.tag_sunny_fill.iconData,
                                  title: 'Sunrise',
                                  value: formatDate2(timeZoneToTime(
                                      weatherInfo.weatherdata!.sys.sunrise)),
                                ),
                                weatherData(
                                  weatherIcon: QWeatherIcons.tag_sunny.iconData,
                                  title: 'Sunset',
                                  value: formatDate2(timeZoneToTime(
                                      weatherInfo.weatherdata!.sys.sunset)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(172, 128, 128,
                            130), // Set the background color here
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ForeCastWeather(),
                        ));
                      },
                      child: const Text(
                        "ForeCast",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
