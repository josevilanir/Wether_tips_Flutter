import 'package:flutter/material.dart';
import '../viewmodels/tip_viewmodel.dart';

class TipScreen extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const TipScreen({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final tip = TipViewModel.getTip(weatherData);

    return Scaffold(
      backgroundColor: const Color(0xFFE5F6FF),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: const Text('Dica do Dia'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
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
                const Icon(
                  Icons.tips_and_updates,
                  size: 48,
                  color: Colors.deepPurple,
                ),
                const SizedBox(height: 16),
                Text(
                  tip,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
