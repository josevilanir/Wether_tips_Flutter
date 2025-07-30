class TipViewModel {
  static String getTip(Map<String, dynamic> weatherData) {
    final condition = weatherData['weather'][0]['main'];

    switch (condition) {
      case 'Clear':
        return 'Está ensolarado! Não esqueça o protetor solar.';
      case 'Rain':
        return 'Vai chover! Leve um guarda-chuva.';
      case 'Clouds':
        return 'Dia nublado, uma jaqueta pode ser útil.';
      case 'Snow':
        return 'Está nevando! Mantenha-se aquecido.';
      default:
        return 'Prepare-se para o clima!';
    }
  }
}
