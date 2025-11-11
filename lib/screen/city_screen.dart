import 'package:flutter/material.dart';
import 'package:weather/constant/constant.dart';

String cityname = '';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: kTextFieldInputDecoration,
            onChanged: (value) {
              // print(value);
              cityname = value;
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, cityname);
            },
            child: Text(
              'Get weather',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
          ),
        ],
      ),
    );
  }
}
