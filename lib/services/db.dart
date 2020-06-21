import 'dart:async';
import 'package:testingflutterapp/models/budget_item.dart';
import 'package:testingflutterapp/models/model.dart';
import 'package:sqflite/sqflite.dart';

abstract class DB {

  static Database _db;

  static int get _version => 1;

  static Future<void> init() async {

    if (_db != null) { return; }

    try {
      String _path = await getDatabasesPath() + 'example';
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    }
    catch(ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE budget_items (id INTEGER PRIMARY KEY NOT NULL, name STRING, value DOUBLE, income BOOLEAN)');
    await db.execute('CREATE TABLE budget (id INTEGER PRIMARY KEY NOT NULL, name STRING, goal DOUBLE)');
    await db.execute('PRAGMA FOREIGN_KEYS = ON');
    //await db.execute('INSERT INTO TABLE budget ( id, name ) VALUES (1,"Buddy Rich")');
    //await db.execute('INSERT INTO TABLE budget ( id, name ) VALUES (2,"Candido")');
    //await db.execute('INSERT INTO TABLE budget ( id, name ) VALUES (3,"Charlie Byrd")');
    await db.execute('CREATE TABLE budget_items_list ( budget_items_id INTEGER, budget_id INTEGER, FOREIGN KEY (budget_items_id) REFERENCES budget_items (id) ON DELETE CASCADE, FOREIGN KEY (budget_id) REFERENCES budget (id) ON DELETE CASCADE)');
  }

  static void deleteTable() async {
    await _db.execute('DROP TABLE IF EXISTS my_table');
  }
  static void deleteData() async {
    await _db.execute('DELETE FROM budget');
    await _db.execute('DELETE FROM budget_items');
    await _db.execute('DELETE FROM budget_items_list');
  }
  static Future<List<Map<String, dynamic>>> rawQuery(String query) async => _db.rawQuery(query);

  static Future<List<Map<String, dynamic>>> query(String table) async => _db.query(table);

  static Future<int> insert(String table, Model model) async =>
      await _db.insert(table, model.toMap());

  static Future<int> update(String table, Model model) async =>
      await _db.update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  static Future<int> delete(String table, Model model) async =>
      await _db.delete(table, where: 'id = ?', whereArgs: [model.id]);
}