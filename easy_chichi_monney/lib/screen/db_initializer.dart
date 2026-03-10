import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBInitializer {
  static const String dbName = "asset_portfolio_with_type.db";

  static Future<String> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    // Nếu DB đã copy rồi → trả về luôn
    if (await databaseExists(path)) {
      return path;
    }

    // Chưa có → copy từ assets
    ByteData data = await rootBundle.load("assets/resource/$dbName");
    List<int> bytes = data.buffer.asUint8List();

    await File(path).writeAsBytes(bytes, flush: true);
    return path;
  }
}
