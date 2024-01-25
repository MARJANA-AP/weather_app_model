import 'package:flutter/material.dart';

class weatherData extends StatelessWidget {
  final IconData weatherIcon;
  final String title;
  final String value;
  const weatherData({
    super.key,
    required this.weatherIcon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 155,
      decoration: BoxDecoration(
          color: const Color.fromARGB(172, 128, 128, 130),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            weatherIcon,
            size: 50,
          ),
          // SizedBox(
          //   width: 10,
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    // color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                value,
                style: const TextStyle(
                    // color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
/////^10.1.0