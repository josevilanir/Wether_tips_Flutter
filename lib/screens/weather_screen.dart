import 'package:flutter/material.dart';
import 'tip_screen.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final forecast = ["Ter - ☀️ 31°C", "Qua - 🌧 28°C", "Qui - ⛅ 30°C"];

    return Scaffold(
      backgroundColor: const Color(0xFFEAF6FF),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
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
            const Text("💧 Umidade: 72%", style: TextStyle(fontSize: 18)),
            const Text("🌬️ Vento: 12 km/h", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Card(
              key: const Key('cardClimaCustomizado'),
              color: Colors.lightBlue[100],
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("☀️ Índice UV: Moderado", style: TextStyle(fontSize: 18)),
                    Text("🧴 Use protetor!",
                        style: TextStyle(fontSize: 16, color: Color(0xFF006064))),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Próximos dias:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 60,
              child: ListView.builder(
                key: const Key('listaPrevisaoDias'),
                scrollDirection: Axis.horizontal,
                itemCount: forecast.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Center(child: Text(forecast[index])),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              key: const Key('botaoVerDica'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TipScreen()),
                );
              },
              child: const Text("Ver Dica do Dia"),
            )
          ],
        ),
      ),
    );
  }
}
