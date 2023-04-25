import 'dart:convert';

import 'package:bugetify_app/models/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = 'tasks';

  static Future<void> initDb() async {
    if (_db != null) {
      debugPrint("not null db");
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      debugPrint("in database path");
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          debugPrint("creating a new one");
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "amount STRING,  note TEXT,date STRING, "
            " category STRING,"
            "color INTEGER)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task task) async {
    print("insert function called");
    return await _db!.insert(_tableName, task.toJson());
  }

  static void addtoserver(Task task) async {
    try {
      var url = Uri.parse('http://192.168.1.12:5000/insertTransac');
      Response response = await post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(task),
      );
      if (response.statusCode == 200) {
        print('success');
      } else {
        print('verification failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<int> delete(Task task) async =>
      await _db!.delete(_tableName, where: 'id = ?', whereArgs: [task.id]);

  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    return _db!.query(_tableName);
  }
}
