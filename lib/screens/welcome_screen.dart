import 'package:flutter/material.dart';
import 'weather_screen.dart';
import 'history_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _ufController = TextEditingController();
  String? _error;

  void _navigateToWeatherScreen() {
    final city = _cityController.text.trim();
    final uf = _ufController.text.trim().toUpperCase();

    if (city.isEmpty || uf.isEmpty || uf.length != 2) {
      setState(() {
        _error = 'Informe cidade e UF válidas (ex: Natal, RN)';
      });
      return;
    }

    setState(() {
      _error = null;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WeatherScreen(cityName: city, stateUf: uf),
      ),
    );
  }

  void _navigateToHistoryScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const HistoryScreen(),
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
              const Icon(Icons.wb_sunny_rounded,
                  size: 72, color: Colors.orange),
              const SizedBox(height: 24),
              const Text(
                'Bem-vindo ao Weather Tips ☀️',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _cityController,
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
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _ufController,
                decoration: InputDecoration(
                  hintText: 'Digite a UF (ex: RN)',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.map),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                textCapitalization: TextCapitalization.characters,
                maxLength: 2,
                onSubmitted: (_) => _navigateToWeatherScreen(),
              ),
              const SizedBox(height: 12),
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
                label:
                    const Text('Buscar clima', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: _navigateToHistoryScreen,
                icon: const Icon(Icons.history),
                label: const Text('Ver histórico de buscas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
