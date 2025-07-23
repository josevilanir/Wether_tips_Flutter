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
      // Mostra um aviso se o campo estiver vazio (opcional)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, digite seu nome')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bem-vindo')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Digite seu nome:', style: TextStyle(fontSize: 20)),
            SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome',
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _navigateToWeatherScreen,
              child: Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}
