import 'package:flutter/material.dart';

class foreCastToday extends StatelessWidget {
  final IconData weatherIcon;
  final String timeC;
  final String temp;
  const foreCastToday({
    super.key,
    required this.weatherIcon,
    required this.timeC,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 160,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 62, 78, 86),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SizedBox(
            //   width: 5,
            // ),
            Icon(
              weatherIcon,
              size: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timeC,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  temp,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
