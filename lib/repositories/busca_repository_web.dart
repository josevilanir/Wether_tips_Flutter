import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';

class BuscaRepository {
  static final _store = intMapStoreFactory.store('buscas');
  static final _db = databaseFactoryWeb.openDatabase('weather_tips_web');

  static Future<void> salvarBusca(String cidade, String uf) async {
    final db = await _db;
    await _store.add(db, {
      'cidade': cidade,
      'uf': uf,
      'data': DateTime.now().toIso8601String(),
    });
  }

  static Future<List<Map<String, dynamic>>> listarBuscas() async {
    final db = await _db;
    final records = await _store.find(
      db,
      finder: Finder(sortOrders: [SortOrder('data', false)]),
    );
    return records.map((e) => e.value).toList();
  }
}
