/*
* File Name        : todo_services.dart
* Group            : trOlsz Group
* Description      : This file is has code for managing all database
*                    related queries like storing, retrieving and deleting
*                    for To-Do List Functionality.
*/

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:chronicles/utilities/components/todo/todo.dart';

import 'package:chronicles/utilities/data/user_auth_data.dart';

class ToDoDatabaseService {
  static Database? _db;
  static final ToDoDatabaseService instance =
      ToDoDatabaseService._constructor();

  final String _todoTableName = 'todolist';
  final String _todoIdColumnName = 'id';
  final String _todoContentColumnName = 'content';
  final String _todoStatusColumnName = 'status';
  final String _todoDateTimeName = 'timestamp';
  final String _todoIndexColumnName = '_todoIndex';

  ToDoDatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await getDatabase();
    return _db!;
  }

  static Future<Directory> _getAppDocumentsDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory;
  }

  Future<Database> getDatabase() async {
    String userId = await UserDataFetcher().fetchUID();

    Directory appDocDir = await _getAppDocumentsDirectory();

    final dbDirPath = await getDatabasesPath();
    final dbPath = '${appDocDir.path}/$userId/$dbDirPath/todo_database.db';
    final database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $_todoTableName (
          $_todoIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
          $_todoIndexColumnName INTEGER NOT NULL,
          $_todoContentColumnName TEXT NOT NULL,
          $_todoStatusColumnName INTEGER NOT NULL,
          $_todoDateTimeName INTEGER
        )
        ''');
      },
    );
    return database;
  }

  Future<void> addToDoTask(int newIndex) async {
    final db = await database;
    await db.insert(
      _todoTableName,
      {
        _todoIndexColumnName: newIndex,
        _todoContentColumnName: 'Enter Task',
        _todoStatusColumnName: 0,
        _todoDateTimeName: DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  Future<void> updateToDoIndex(int index, int id) async {
    final db = await database;
    await db.update(
      _todoTableName,
      {_todoIndexColumnName: index},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<ToDo>> fetchToDoTasks({required bool isComplete}) async {
    final db = await database;
    final data = await db.query(
      _todoTableName,
      where: '$_todoStatusColumnName = ?',
      whereArgs: [isComplete ? 1 : 0],
      orderBy: '$_todoIndexColumnName ASC',
    );
    List<ToDo> todoList = data
        .map(
          (e) => ToDo(
              id: e["id"] as int,
              index: e["_todoIndex"] as int,
              content: e["content"] as String,
              status: e["status"] as int,
              millisecondSinceEpoch: e["timestamp"] as int),
        )
        .toList();
    return todoList;
  }

  Future<List<ToDo>> fetchRecentToDos({required int limitRecentToDo}) async {
    final db = await database;
    final data = await db.query(
      _todoTableName,
      where: '$_todoStatusColumnName = ?',
      whereArgs: [0],
      orderBy: '_todoIndex ASC',
      limit: limitRecentToDo,
    );

    List<ToDo> todoList = data
        .map(
          (e) => ToDo(
            id: e["id"] as int,
            index: e["_todoIndex"] as int,
            content: e["content"] as String,
            status: e["status"] as int,
            millisecondSinceEpoch: e["timestamp"] as int,
          ),
        )
        .toList();

    return todoList;
  }

  Future<void> updateToDoTask(int id, String content) async {
    final db = await database;
    await db.update(
      _todoTableName,
      {_todoContentColumnName: content},
      where: '$_todoIdColumnName = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateTodoStatus(int id, int status) async {
    final db = await database;
    await db.update(
      _todoTableName,
      {_todoStatusColumnName: status},
      where: '$_todoIdColumnName = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteToDoTask(int id) async {
    final db = await database;
    await db.delete(
      _todoTableName,
      where: '$_todoIdColumnName = ?',
      whereArgs: [id],
    );
  }
}
