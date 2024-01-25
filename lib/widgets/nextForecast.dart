import 'package:flutter/material.dart';

// ignore: camel_case_types
class nextForecast extends StatelessWidget {
  final IconData weatherIcon;
  final String date;
  final String day;
  final String descp;
  final String temp;
  const nextForecast({
    super.key,
    required this.weatherIcon,
    required this.date,
    required this.day,
    required this.descp,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 62, 78, 86),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 5),
            child: Icon(
              weatherIcon,
              size: 40,
            ),
          ),
          const SizedBox(
            width: 22,
          ),
          Column(
            children: [
              Text(
                date,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                width: 22,
              ),
              Text(
                day,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(
            width: 22,
          ),
          Text(
            descp,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            width: 22,
          ),
          Text(
            temp,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
