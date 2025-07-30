import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class WeatherService {
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> fetchWeather(double lat, double lon) async {
    final apiKey = Platform.environment['OPENWEATHER_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('OPENWEATHER_API_KEY not found in environment');
    }

    final url = Uri.parse('$_baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=pt_br');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch weather: ${response.statusCode}');
    }

    return json.decode(response.body) as Map<String, dynamic>;
  }
}
