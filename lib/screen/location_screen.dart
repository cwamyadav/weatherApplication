import 'package:flutter/material.dart';
import 'package:weather/constant/constant.dart';
import 'package:weather/screen/city_screen.dart';
import 'package:weather/widget/hourly_weather_forecast.dart';
import 'package:weather/widget/weather_forecast.dart';
import '../services/weather.dart';

class LocationScreen extends StatefulWidget {
  final dynamic locationWeather;
  const LocationScreen({super.key, this.locationWeather});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  List hourlyForecast = [];
  WeatherModel weather = WeatherModel();
  String weatherIcon = '';
  String weathermessage = '';
  int condition = 0;
  int temp = 0;
  double temeperature = 0.0;
  String cityName = 'any City not matter';
  double humidity = 0;
  double windSpeed = 0;
  double pressure = 0;

  @override
  void initState() {
    super.initState();
    updateUi(widget.locationWeather);
  }

  void updateUi(dynamic weatherResponse) {
    if (weatherResponse == null) {
      temeperature = 0;
      weatherIcon = 'Error';
      weathermessage = 'Unable to get the weather data';
      cityName = '';
      return;
    }

    final weatherData = weatherResponse['weatherData'];
    final hourly =
        weatherResponse['hourly']; // 👈 access hourly data from NetworkHelper

    setState(() {
      temeperature = weatherData['list'][0]['main']['temp'];
      temp = temeperature.toInt();
      cityName = weatherData['city']['name'];
      condition = weatherData['list'][0]['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weathermessage = weather.getMessage(temp);
      humidity = weatherData['list'][0]['main']['humidity'].toDouble();
      windSpeed = weatherData['list'][0]['wind']['speed'].toDouble();
      pressure = weatherData['list'][0]['main']['pressure'].toDouble(); // added
      hourlyForecast = hourly; //  store hourly forecast for display
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 20),
                FloatingActionButton(
                  heroTag: 'near me',
                  onPressed: () async {
                    // var weatherData = await weather.getLocationWeather();
                    // updateUi(weatherData);
                  },
                  child: Icon(Icons.location_on_outlined, size: 50),
                ),
                Spacer(),
                FloatingActionButton(
                  heroTag: 'Desired city',
                  onPressed: () async {
                    var typedName = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CityScreen(),
                      ),
                    );
                    if (typedName != null) {
                      var weatherData = await weather.getCityWeather(typedName);
                      updateUi(weatherData);
                    }
                  },
                  child: Icon(
                    Icons.location_city,
                    size: 50,
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
            Text(
              '$temp°C',
              style: Kstyling,
              textAlign: TextAlign.center,
            ),
            Text('$weatherIcon', style: Kstyling),
            Text(
              '$weathermessage in',
              style: Kstyling,
              textAlign: TextAlign.center,
            ),
            Text(' $cityName ', style: Kstyling),
            Spacer(),
            Row(
              children: [
                SizedBox(width: 10),
                Text(
                  'Weather Forecast',
                  style: TextStyle(
                    color: Colors.lightGreenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 33,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: hourlyForecast.length,
                  itemBuilder: (context, index) {
                    final hour = hourlyForecast[index];
                    // Extract just "HH:MM" from "YYYY-MM-DD HH:MM:SS"
                    final time = hour['time'].substring(11, 16);
                    final temp = hour['temp'].toStringAsFixed(0);
                    return HourlyForeCastItem(
                      time: time, //  show forecast time dynamically
                      icon: Icons.wb_sunny, // you can map icon later if needed
                      text: '$temp°C',
                    );
                  },
                ),
              ),
            ),
            Text(
              'Additional Information',
              style: TextStyle(
                color: Colors.lightGreenAccent,
                fontSize: 33,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WeatherForecastItem(
                  icon: Icons.water_drop,
                  weatherreport: 'Humidity',
                  value: '$humidity',
                ),
                WeatherForecastItem(
                    icon: Icons.air,
                    weatherreport: 'Wind',
                    value: '$windSpeed'),
                WeatherForecastItem(
                  icon: Icons.beach_access,
                  weatherreport: 'Pressure',
                  value: '$pressure',
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
