import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class BuscaRepository {
  static final _store = intMapStoreFactory.store('buscas');
  static Database? _db;

  static Future<Database> _getDb() async {
    if (_db != null) return _db!;
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'weather_tips.db');
    _db = await databaseFactoryIo.openDatabase(path);
    return _db!;
  }

  static Future<void> salvarBusca(String cidade) async {
    final db = await _getDb();
    await _store.add(db, {
      'cidade': cidade,
      'data': DateTime.now().toIso8601String(),
    });
  }

  static Future<List<Map<String, dynamic>>> listarBuscas() async {
    final db = await _getDb();
    final records = await _store.find(db,
        finder: Finder(sortOrders: [SortOrder('data', false)]));
    return records.map((e) => e.value).toList();
  }
}
