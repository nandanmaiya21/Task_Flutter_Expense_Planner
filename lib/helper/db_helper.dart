import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  //For Transaction;
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'expenses.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE expenses(id TEXT PRIMARY KEY,title TEXT,amount REAL, date TEXT, category TEXT, spendtype TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();

    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();

    return db.query(table);
  }

  static Future<void> delete(String table, String id) async {
    final db = await DBHelper.database();
    db.rawDelete("DELETE FROM $table WHERE id = '$id'");
  }

  static Future<void> update(
    String table,
    String title,
    double amount,
    String date,
    String category,
    String spendtype,
    String id,
  ) async {
    final db = await DBHelper.database();
    db.rawUpdate(
      "UPDATE $table SET title = '$title', amount = $amount, date = '$date', category = '$category', spendtype = '$spendtype' WHERE id = '$id'",
    );
  }
}
