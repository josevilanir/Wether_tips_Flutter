import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/tip_viewmodel.dart';

class TipScreen extends StatelessWidget {
  const TipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tipViewModel = Provider.of<TipViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFEAF6FF),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("💡 Dica do Dia",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  key: Key('tituloDica')),
              const SizedBox(height: 16),
              Text(
                tipViewModel.dicaAtual,
                key: const Key('textoDicaAtual'),
                style: const TextStyle(fontSize: 20, color: Color(0xFF003366)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                key: const Key('botaoNovaDica'),
                onPressed: () {
                  tipViewModel.gerarNovaDica();
                },
                child: const Text("🔄 Ver outra dica"),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                key: const Key('botaoVoltar'),
                onPressed: () => Navigator.pop(context),
                child: const Text("⬅️ Voltar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
