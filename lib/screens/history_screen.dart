import 'package:flutter/material.dart';
import '../repositories/busca_repository.dart';
import 'weather_screen.dart';

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

  void _abrirClima(String cidade, String estado) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WeatherScreen(cityName: cidade, stateUf: estado),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F6FF),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: const Text('Histórico de Buscas'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _buscasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Nenhuma cidade buscada ainda.'),
            );
          }

          final dados = snapshot.data!;

          return ListView.separated(
            itemCount: dados.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final cidade = dados[index]['cidade'];
              final estado = dados[index]['estado'] ?? '';
              return ListTile(
                title: Text('$cidade - $estado'),
                leading: const Icon(Icons.location_city),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _abrirClima(cidade, estado),
              );
            },
          );
        },
      ),
    );
  }
}
