import 'package:flutter/material.dart';
import 'weather_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _navigateToWeatherScreen() {
    final name = _nameController.text.trim();
    if (name.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherScreen(userName: name),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, digite seu nome')),
      );
    }
  }

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
              // Conteúdo original da tela
              const Text(
                'Bem-vindo ao Weather Tips!',
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF003366),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Text(
                'Veja a previsão do tempo da sua cidade\n'
                'e receba dicas de saúde personalizadas.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // Novo campo para digitar o nome
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Digite seu nome',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _navigateToWeatherScreen,
                child: const Text('Continuar'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
