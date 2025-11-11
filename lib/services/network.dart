import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;
  NetworkHelper(this.url);

  Future<Map<String, dynamic>> getData() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);

      // Extract hourly list (first 10 entries from forecast)
      final List forecastList = decodedData['list'];
      final hourlyForecast = forecastList.take(10).map((hour) {
        return {
          'time': hour['dt_txt'],
          'temp': hour['main']['temp'],
          'icon': hour['weather'][0]['icon'],
          'desc': hour['weather'][0]['description'],
        };
      }).toList();

      return {
        'weatherData': decodedData,
        'hourly': hourlyForecast,
      };
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
