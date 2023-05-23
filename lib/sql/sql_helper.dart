// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE contacts(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      nom TEXT ,
      prenom TEXT ,
      tel INTEGER ,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbtech.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createContact(String nom, String? prenom, int tel) async {
    final db = await SQLHelper.db();
    final data = {
      'nom': nom,
      'prenom': prenom,
      'tel': tel,
    };
    final id = await db.insert(
      'contacts',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<List<Map<String, dynamic>>> getContcts() async {
    final db = await SQLHelper.db();

    return db.query('contacts', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getContact(int id) async {
    final db = await SQLHelper.db();
    return db.query('contacts', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateContact(
      int id, String title, String? description) async {
    final db = await SQLHelper.db();
    final data = {
      'title': title,
      'description': description,
      'createjdAt': DateTime.now().toString()
    };
    final result = await db.update('contacts', data,
        where: "id = ?",
        whereArgs: [id],
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return result;
  }

  static Future<void> deleteContact(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('contacts', where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("somthing went wrong when deleting an item : $err");
    }
  }
}
