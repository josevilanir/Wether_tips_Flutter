import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _apiKey = 'd211faebc5c7af2e4a92db88f4389ccc';

  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  static Future<Map<String, dynamic>> fetchWeather(String cityName) async {
    final url = Uri.parse(
      '$_baseUrl/weather?q=$cityName&appid=$_apiKey&units=metric&lang=pt',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha ao buscar dados do clima');
    }
  }
}
