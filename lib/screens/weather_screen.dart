import 'package:flutter/material.dart';
import 'tip_screen.dart';

class WeatherScreen extends StatelessWidget {
  final String userName;
  const WeatherScreen({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final forecast = ["Ter - ☀️ 31°C", "Qua - 🌧 28°C", "Qui - ⛅ 30°C"];

    return Scaffold(
      backgroundColor: const Color(0xFFEAF6FF),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            // Saudação com o nome do usuário
            if (userName.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  'Bem-vindo, $userName!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            const Text("Tempo agora em Natal - RN",
                style: TextStyle(
                    fontSize: 22, color: Color(0xFF003366)),
                key: Key('tituloClimaAtual')),
            const SizedBox(height: 8),
            const Text("Segunda-feira, 06 de Maio"),
            const Text("Atualizado às 17:30", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 32),
            const Text("🌡️ Temperatura: 29°C", style: TextStyle(fontSize: 18)),
            const Text("🤒 Sensação térmica: 31°C", style: TextStyle(fontSize: 18)),
            const Text("💧 Umidade: 76%", style: TextStyle(fontSize: 18)),
            const Text("💨 Vento: 19 km/h", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            const Text("Próximos dias", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...forecast.map((item) => ListTile(title: Text(item))).toList(),
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
        ),
      ),
    );
  }
}
