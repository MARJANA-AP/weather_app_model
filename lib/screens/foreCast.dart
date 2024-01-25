import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_model/model/forecast_weather_model.dart';
import 'package:weather_app_model/proviider/forecastProvider.dart';
import 'package:weather_app_model/proviider/weatherProvider.dart';

class ForeCastWeather extends StatefulWidget {
  const ForeCastWeather({super.key});

  @override
  State<ForeCastWeather> createState() => _ForeCastWeatherState();
}

class _ForeCastWeatherState extends State<ForeCastWeather> {
  @override
  void initState() {
    super.initState();
    Provider.of<WeatherDetails>(context, listen: false).fetchData();
    Provider.of<ForecastDetails>(context, listen: false).fetchForecast();
  }

//conver fahrenheit to celcius
  int convertToFahrenheit(double fahrenheit) {
    return ((fahrenheit - 32) * 5 / 9).round();
  }

//To convert MillisecondsSinceEpoch to DateTime
  DateTime? unpackDate(dynamic k) {
    int millis = k * 1000;
    return DateTime.fromMillisecondsSinceEpoch(millis);
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

  String formatDateTime(DateTime dateTime) {
    // Format the date with day on the first line and abbreviated month, date on the second line
    final formattedDate = DateFormat('EEEE').format(dateTime) +
        '\n' +
        DateFormat('MMM d').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final forecastInfo = Provider.of<ForecastDetails>(context);
    final weatherInfo = Provider.of<WeatherDetails>(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.3, 0.5, 0.7, 0.9],
          colors: <Color>[
            Color.fromARGB(255, 102, 103, 104),
            Color.fromARGB(255, 94, 96, 97),
            Color.fromARGB(255, 154, 156, 158),
            Color.fromARGB(184, 78, 81, 81),
            Color.fromARGB(255, 100, 101, 101),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color(0x00000000),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: weatherInfo.weatherdata == null && forecastInfo.isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          weatherInfo.weatherdata!.name,
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                                fontSize: 35, letterSpacing: .5),
                          ),
                        ),
                      ),
                      Text(
                        formatDate2(
                            timeZoneToTime(weatherInfo.weatherdata!.timezone)),
                        style: GoogleFonts.lato(
                          textStyle:
                              const TextStyle(fontSize: 35, letterSpacing: .5),
                        ),
                      ),
                      const Text(
                        "Forecast Details",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Today",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              formatDate(
                                  unpackDate(weatherInfo.weatherdata!.dt)),
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    fontSize: 20, letterSpacing: .5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer<ForecastDetails>(
                        builder: (context, value, child) {
                          DateTime currentDate = DateTime.now();

                          List<ListElement> forecastData =
                              value.forecastdata!.list;

                          List<ListElement> currentDayForecast = forecastData
                              .where((forecast) =>
                                  forecast.dtTxt.year == currentDate.year &&
                                  forecast.dtTxt.month == currentDate.month &&
                                  forecast.dtTxt.day == currentDate.day)
                              .toList();

                          return SizedBox(
                            height: 90,
                            child: value.forecastdata == null
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: currentDayForecast.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 80,
                                          width: 140,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color.fromARGB(
                                                  172, 128, 128, 130)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                width: 60,
                                                child: Image.network(
                                                  // " https://openweathermap.org/img/wn/${currentDayForecast[index].weather[0].icon}@2x.png",
                                                  "https://openweathermap.org/img/wn/${currentDayForecast[index].weather[0].icon}@2x.png"
                                                  //  currentDayForecast[index].weather[0].icon
                                                  ,
                                                  height: 70,
                                                  width: 35,
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    formatDate2(
                                                        currentDayForecast[
                                                                index]
                                                            .dtTxt),
                                                    style: const TextStyle(
                                                        fontSize: 15),
                                                  ),
                                                  Text(
                                                    "${convertToFahrenheit(currentDayForecast[index].main.temp)} \u00B0C",
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "5 Days Forecast",
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                      Consumer<ForecastDetails>(
                          builder: (context, value, child) {
                        List<ListElement> forecastData =
                            value.forecastdata!.list;

                        // day by day forecast
                        Map<String, List<ListElement>> groupForecastByDay(
                            List<ListElement> forecastData) {
                          Map<String, List<ListElement>> groupedData = {};

                          for (var element in forecastData) {
                            String date =
                                "${element.dtTxt.year}-${element.dtTxt.month}-${element.dtTxt.day}";

                            if (!groupedData.containsKey(date)) {
                              groupedData[date] = [];
                            }

                            groupedData[date]!.add(element);
                          }

                          return groupedData;
                        }

                        Map<String, List<ListElement>> groupedData =
                            groupForecastByDay(forecastData);

                        return SizedBox(
                          height: 250,
                          child: value.forecastdata == null
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              :

                              // child: SizedBox(
                              //   height: 250,

                              //   child:
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 5,

                                  // scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    String date =
                                        groupedData.keys.elementAt(index);
                                    List<ListElement> dailyData =
                                        groupedData[date]!;
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 60,
                                        width: 140,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color.fromARGB(
                                              172, 128, 128, 130),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            // Column(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment.spaceEvenly,
                                            //   children: [
                                            //     Text(
                                            //       "Friday",
                                            //       style: TextStyle(fontSize: 15),
                                            //     ),
                                            //     Text("May,28",
                                            //         style: TextStyle(
                                            //           fontSize: 15,
                                            //         ))
                                            //   ],
                                            // ),
                                            Text(formatDateTime(
                                                unpackDate(dailyData[index].dt)
                                                    as DateTime)),
                                            Row(
                                              children: [
                                                Text(
                                                    "${convertToFahrenheit(dailyData[index].main.tempMin)} \u00B0C",
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                    )),
                                                Text(
                                                    " \\ ${convertToFahrenheit(dailyData[index].main.tempMax)} \u00B0C",
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                    )),
                                              ],
                                            ),
                                            Image.network(
                                              // " https://openweathermap.org/img/wn/${currentDayForecast[index].weather[0].icon}@2x.png",
                                              "https://openweathermap.org/img/wn/${dailyData[index].weather[0].icon}@2x.png"
                                              //  currentDayForecast[index].weather[0].icon
                                              ,
                                              height: 70,
                                              width: 35,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
