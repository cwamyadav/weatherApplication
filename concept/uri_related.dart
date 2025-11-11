import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  double latitude = 12.3432;
  double longitude = 15.343;
  const apiKey = 'bd7cb41024bab5dceb59e9f07d67a21e';
  const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';
  // creating the url
  final Uri url = Uri.https(
    'api.openweathermap.org',
    '/data/2.5/weather',
    {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'appid': apiKey,
      'units': 'metric',
    },
  );
  print('✅ URL created: $url\n');
  final response = await http.get(url); // sending the request
  String jsonString = response.body; //Getting the json
  var decodedData = jsonDecode(jsonString);
  print(decodedData);
  print('Base: ${decodedData['base']}');
}
