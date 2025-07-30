import 'package:flutter/material.dart';
import 'weather_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _error;

  void _navigateToWeatherScreen() {
    final city = _controller.text.trim();

    if (city.isEmpty) {
      setState(() {
        _error = 'Digite o nome de uma cidade';
      });
      return;
    }

    setState(() {
      _error = null;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WeatherScreen(cityName: city),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F6FF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.wb_sunny_rounded,
                size: 72,
                color: Colors.orange,
              ),
              const SizedBox(height: 24),
              const Text(
                'Bem-vindo ao Weather Tips ☀️',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Digite o nome da cidade',
                  filled: true,
                  fillColor: Colors.white,
                  errorText: _error,
                  prefixIcon: const Icon(Icons.location_city),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _navigateToWeatherScreen(),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _navigateToWeatherScreen,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[300],
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.search),
                label: const Text(
                  'Buscar clima',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
