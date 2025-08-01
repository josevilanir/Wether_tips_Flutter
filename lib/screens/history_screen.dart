import 'package:flutter/material.dart';
import 'weather_screen.dart';
import '../repositories/busca_repository.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<Map<String, dynamic>>> _buscasFuture;

  @override
  void initState() {
    super.initState();
    _buscasFuture = BuscaRepository.listarBuscas();
  }

  void _abrirClima(String cidade) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WeatherScreen(cityName: cidade),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F6FF),
      appBar: AppBar(
        title: const Text('Histórico de Buscas'),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _buscasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Nenhuma cidade buscada ainda.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          final buscas = snapshot.data!;

          return ListView.separated(
            itemCount: buscas.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final item = buscas[index];
              final cidade = item['cidade'] ?? 'Desconhecida';
              final data = DateTime.tryParse(item['data'] ?? '') ??
                  DateTime.fromMillisecondsSinceEpoch(0);

              return ListTile(
                leading:
                    const Icon(Icons.location_city, color: Colors.deepPurple),
                title: Text(cidade),
                subtitle: Text(
                  'Buscado em ${data.day}/${data.month}/${data.year} às ${data.hour.toString().padLeft(2, '0')}:${data.minute.toString().padLeft(2, '0')}',
                ),
                onTap: () => _abrirClima(cidade), // 👈 Ação ao tocar na cidade
              );
            },
          );
        },
      ),
    );
  }
}
