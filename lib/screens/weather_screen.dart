import 'package:flutter/material.dart';

import '../services/weather_service.dart';
import 'tip_screen.dart';

class WeatherScreen extends StatefulWidget {
  final String userName;
  const WeatherScreen({super.key, required this.userName});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _service = WeatherService();
  Map<String, dynamic>? _weatherData;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    try {
      final data = await _service.fetchWeather(-5.77926, -35.20092);
      setState(() {
        _weatherData = data;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final forecast = ['Ter - ☀️ 31°C', 'Qua - 🌧 28°C', 'Qui - ⛅ 30°C'];

    Widget content;
    if (_error != null) {
      content = Center(child: Text('Erro: $_error'));
    } else if (_weatherData == null) {
      content = const Center(child: CircularProgressIndicator());
    } else {
      final main = _weatherData?['main'] ?? {};
      final wind = _weatherData?['wind'] ?? {};
      content = ListView(
        children: [
          if (widget.userName.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                'Bem-vindo, ${widget.userName}!',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          const Text(
            'Tempo agora em Natal - RN',
            style: TextStyle(fontSize: 22, color: Color(0xFF003366)),
            key: Key('tituloClimaAtual'),
          ),
          const SizedBox(height: 8),
          Text(
            _weatherData?['dt'] != null
                ? DateTime.fromMillisecondsSinceEpoch(_weatherData?['dt'] * 1000)
                    .toLocal()
                    .toString()
                : '',
          ),
          const SizedBox(height: 32),
Text('🌡️ Temperatura: ${main['temp']}°C',
              style: const TextStyle(fontSize: 18)),
          Text('🤒 Sensação térmica: ${main['feels_like']}°C',
              style: const TextStyle(fontSize: 18)),
          Text('💧 Umidade: ${main['humidity']}%',
              style: const TextStyle(fontSize: 18)),
          Text('💨 Vento: ${wind['speed']} m/s',
              style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),
          const Text('Próximos dias',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ...forecast.map((item) => ListTile(title: Text(item))),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TipScreen()),
              );
            },
            child: const Text('Dicas de Saúde'),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFEAF6FF),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: content,
      ),
    );
  }
}

