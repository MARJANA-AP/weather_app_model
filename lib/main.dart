import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_model/proviider/forecastProvider.dart';
import 'package:weather_app_model/proviider/weatherProvider.dart';
import 'package:weather_app_model/screens/homePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<WeatherDetails>(
          create: (_) => WeatherDetails(), child: const MyApp()),
      ChangeNotifierProvider<ForecastDetails>(
          create: (_) => ForecastDetails(), child: const MyApp()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
