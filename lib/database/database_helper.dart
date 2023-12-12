import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLHelper {
  static const databaseName = 'MyDatabase.db';
  static const databaseVersion = 1;
  static const tableName = 'db_photos';

  SQLHelper._privateConstructor();
  static final SQLHelper instance = SQLHelper._privateConstructor();

  static Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE $tableName(
        "albumId"	INTEGER NOT NULL,
        "id"	INTEGER NOT NULL,
        "title"	TEXT NOT NULL,
        "url"	TEXT NOT NULL,
        "thumbnailUrl"	TEXT NOT NULL
      );
      """);
  }

  static Future<Database> initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, databaseName);
    return openDatabase(
      path,
      version: databaseVersion,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(Map<String, dynamic> row) async {
    final db = await SQLHelper.initDatabase();
    return await db.insert(tableName, row);
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.initDatabase();
    return await db.query(tableName);
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.initDatabase();
    return db.query(tableName, where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(Map<String, dynamic> row) async {
    final db = await SQLHelper.initDatabase();
    int id = row['id'];
    final result =
        await db.update(tableName, row, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.initDatabase();
    try {
      await db.delete(tableName, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
