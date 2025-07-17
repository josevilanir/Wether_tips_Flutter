import 'package:flutter/material.dart';
import 'weather_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF6FF),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wb_sunny, size: 80, key: Key('iconeLogo')),
              const SizedBox(height: 24),
              const Text('WeatherWise',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003366)),
                  key: Key('tituloApp')),
              const SizedBox(height: 32),
              const Text('Seja bem-vindo!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Permita acesso à sua localização para ver previsões do tempo',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  key: Key('descricaoPermissao'),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                key: const Key('botaoUsarLocalizacao'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const WeatherScreen()),
                  );
                },
                child: const Text("Usar minha localização atual"),
              ),
              const SizedBox(height: 32),
              const Icon(Icons.map, size: 150, key: Key('imagemMapa')),
            ],
          ),
        ),
      ),
    );
  }
}
