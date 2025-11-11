import 'package:flutter/material.dart';

class WeatherForecastItem extends StatelessWidget {
  final IconData icon;
  final String weatherreport;
  final String value;
  const WeatherForecastItem(
      {required this.icon,
      required this.weatherreport,
      required this.value,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icon),
          Text(
            weatherreport,
            style: TextStyle(
                fontSize: 15,
                color: Colors.white),
          ),
          Text(
            value,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
