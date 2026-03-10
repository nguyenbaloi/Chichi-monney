import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'db_initializer.dart';
import 'package:easy_chichi_monney/model/asset.dart';
import 'package:easy_chichi_monney/model/history.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    final dbPath = await DBInitializer.initDatabase();
    _database = await openDatabase(dbPath);

    return _database!;
  }

  // ---------------------------------------------------------
  // ASSETS
  // ---------------------------------------------------------
  Future<List<Asset>> getAssets() async {
    final db = await database;
    final maps = await db.query('assets');
    return maps.map((json) => Asset.fromJson(json)).toList();
  }

  Future<int> insertAsset(Asset asset) async {
    final db = await database;
    return db.insert('assets', asset.toJson());
  }

  Future<int> updateAsset(Asset asset) async {
    final db = await database;
    return db.update(
      'assets',
      asset.toJson(),
      where: "id = ?",
      whereArgs: [asset.id],
    );
  }

  Future<int> deleteAsset(int id) async {
    final db = await database;
    return db.delete(
      'assets',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // ---------------------------------------------------------
  // HISTORY
  // ---------------------------------------------------------
  Future<List<History>> getHistory() async {
    final db = await database;
    final maps = await db.query('history', orderBy: "date ASC");
    return maps.map((json) => History.fromJson(json)).toList();
  }

  Future<int> insertHistory(History h) async {
    final db = await database;
    return db.insert('history', h.toJson());
  }

  Future<int> updateHistory(History h) async {
    final db = await database;
    return db.update(
      'history',
      h.toJson(),
      where: "id = ?",
      whereArgs: [h.id],
    );
  }

  Future<int> deleteHistory(int id) async {
    final db = await database;
    return db.delete(
      'history',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // Tổng nạp
  Future<int> getTotalDeposit() async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT total_invest FROM history ORDER BY id DESC LIMIT 1");

    return res.isNotEmpty ? res.first["total_invest"] as int : 0;
  }
// tổng lãi lỗ
  Future<int> getTotalProfit() async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT current_asset - total_invest AS result "
            "FROM history ORDER BY id DESC LIMIT 1");

    return res.isNotEmpty ? res.first["result"] as int : 0;
  }
  // Tổng ts

  Future<int> getLastTotalInvest() async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT total_invest FROM history ORDER BY id DESC LIMIT 1");

    if (res.isNotEmpty) {
      return res.first["total_invest"] as int;
    }
    return 0;
  }

}
