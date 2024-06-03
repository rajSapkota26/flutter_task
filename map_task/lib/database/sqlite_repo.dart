import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import '../feature/todo/todo.dart';
import 'database.dart';
final sqlRepoProvider =
Provider<SqliteRepo>((_) => SqliteRepo());
class SqliteRepo {
  static final SqliteRepo _instance = SqliteRepo._private();

  factory SqliteRepo() {
    return _instance;
  }

  SqliteRepo._private();
  Future<void> insertTodoList(List<Todo> todos) async {
    final db = await AppDatabase.instance.database;

    for (var todo in todos) {
      log("todo ${todo.toJson()}");
      await db.insert('todos', todo.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<Todo>> fetchTodosFromDB() async {
    final db = await AppDatabase.instance.database;

    final result = await db.query('todos');

    return result.map((json) => Todo.fromJson(json)).toList();
  }
}
