import 'package:flutter/material.dart';

class TipViewModel extends ChangeNotifier {
  final List<String> _dicas = [
    "Leve um guarda-chuva! Pode chover mais tarde.",
    "Hoje está ótimo para um passeio ao ar livre.",
    "Não se esqueça do protetor solar!",
    "Clima ideal para tomar um café quentinho!",
    "Use roupas leves, o calor vai apertar!"
  ];

  String _dicaAtual = "Carregando dica...";

  String get dicaAtual => _dicaAtual;

  TipViewModel() {
    gerarNovaDica();
  }

  void gerarNovaDica() {
    _dicaAtual = (_dicas..shuffle()).first;
    notifyListeners();
  }
}
