import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import 'tip_screen.dart';
import '../repositories/busca_repository.dart';

class WeatherScreen extends StatefulWidget {
  final String cityName;
  final String stateUf; //

  const WeatherScreen({
    super.key,
    required this.cityName,
    required this.stateUf,
  });

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> _weatherFuture;

  @override
  void initState() {
    super.initState();

    // Salva a cidade no histórico (sem o estado, como já era feito)
    BuscaRepository.salvarBusca(widget.cityName, widget.stateUf);

    _weatherFuture =
        WeatherService.fetchWeather(widget.cityName, widget.stateUf);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F6FF),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: Text('Clima em ${widget.cityName} - ${widget.stateUf}'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _weatherFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao buscar o clima: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final data = snapshot.data!;
          final main = data['main'];
          final weather = data['weather'][0];
          final wind = data['wind'];

          final tempCelsius = main['temp'].round();
          final windSpeedKmh = (wind['speed'] * 3.6).round();

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      weather['description'].toString().toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '$tempCelsius°C',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.water_drop_outlined,
                            color: Colors.blue),
                        const SizedBox(width: 6),
                        Text('Umidade: ${main['humidity']}%'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.air, color: Colors.grey),
                        const SizedBox(width: 6),
                        Text('Vento: $windSpeedKmh km/h'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TipScreen(weatherData: data),
                          ),
                        );
                      },
                      icon: const Icon(Icons.lightbulb),
                      label: const Text('Ver dica baseada no clima'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple[100],
                        foregroundColor: Colors.deepPurple[900],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
