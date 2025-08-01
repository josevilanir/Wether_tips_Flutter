import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class BuscaRepository {
  static final _store = intMapStoreFactory.store('buscas');

  static Future<Database> get _db async {
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    final dbPath = join(dir.path, 'weather_tips.db');
    return databaseFactoryIo.openDatabase(dbPath);
  }

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
