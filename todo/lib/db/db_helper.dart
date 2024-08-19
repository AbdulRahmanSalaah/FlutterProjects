import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'tasks';

  static Future<void> initDb() async {
    //
    if (_db != null) {
      debugPrint('not null db');
      return;
    }

    try {
      String path = '${await getDatabasesPath()}task.db';
      debugPrint('in database path');
      _db = await openDatabase(path, version: _version,
          onCreate: (Database db, int version) async {
        debugPrint('creating a new one');
        return db.execute(
          'CREATE TABLE $_tableName('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'title STRING, note TEXT, date STRING, '
          'startTime STRING, endTime STRING, '
          'remind INTEGER, repeat STRING, '
          'color INTEGER, '
          'isCompleted INTEGER)',
        );
      });
      debugPrint('Database Created');
    } catch (e) {
      debugPrint('Error = $e');
    }
  }

  static Future<int> insert(Task? task) async {
    debugPrint('insert function called');
    return await _db!
        .insert(_tableName, task!.toJson() )
        ;
  }

  static Future<int> delete(Task task) async {
    debugPrint('delete function called');
    return await _db!.delete(_tableName, where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<int> deleteAll() async {
    debugPrint('delete All function called');
    return await _db!.delete(_tableName);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    debugPrint('query function called');
    return await _db!.query(_tableName);
  }

  static Future<int> update(int id) async {
    debugPrint('update function called');
    return await _db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id = ?
   ''', [1, id]);
  }
}
