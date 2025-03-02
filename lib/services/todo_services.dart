import 'package:chronicles/services/secure_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:chronicles/utilities/components/todo/todo.dart';

class ToDoDatabaseService {
  static Database? _db;
  static final ToDoDatabaseService instance =
      ToDoDatabaseService._constructor();

  final String _todoTableName = 'todolist';
  final String _todoIdColumnName = 'id';
  final String _todoContentColumnName = 'content';
  final String _todoStatusColumnName = 'status';
  final String _todoDateTimeName = 'timestamp';

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
    SecureStorage storage = SecureStorage();
    String user_id = await storage.readSecureData('user_id');

    Directory appDocDir = await _getAppDocumentsDirectory();

    final dbDirPath = await getDatabasesPath();
    final dbPath = '${appDocDir.path}/$user_id/$dbDirPath/todo_database.db';
    final database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $_todoTableName (
          $_todoIdColumnName INTEGER PRIMARY KEY,
          $_todoContentColumnName TEXT NOT NULL,
          $_todoStatusColumnName INTEGER NOT NULL,
          $_todoDateTimeName INTEGER
        )
        ''');
      },
    );
    return database;
  }

  void addToDoTask(int millisSinceEpoch) async {
    final db = await database;
    await db.insert(
      _todoTableName,
      {
        _todoContentColumnName: 'Enter Task',
        _todoStatusColumnName: 0,
        _todoDateTimeName: millisSinceEpoch,
      },
    );
  }

  Future<List<ToDo>> fetchPendingToDoTasks() async {
    final db = await database;
    final data = await db.query(
      _todoTableName,
      where: '$_todoStatusColumnName = ?',
      whereArgs: [0],
    );
    List<ToDo> todoList = data
        .map(
          (e) => ToDo(
              index: e["id"] as int,
              content: e["content"] as String,
              status: e["status"] as int,
              millisecondSinceEpoch: e["timestamp"] as int),
        )
        .toList();
    print(todoList);
    return todoList;
  }

  Future<List<ToDo>> fetchCompletedToDoTasks() async {
    final db = await database;
    final data = await db.query(
      _todoTableName,
      where: '$_todoStatusColumnName = ?',
      whereArgs: [1],
    );
    List<ToDo> todoList = data
        .map(
          (e) => ToDo(
              index: e["id"] as int,
              content: e["content"] as String,
              status: e["status"] as int,
              millisecondSinceEpoch: e["timestamp"] as int),
        )
        .toList();
    return todoList;
  }

  Future<List<ToDo>> fetchTop3ToDos() async {
    final db = await database;
    final data = await db.query(
      _todoTableName,
      where: '$_todoStatusColumnName = ?',
      whereArgs: [0],
      orderBy: '$_todoDateTimeName ASC',
      limit: 3,
    );

    List<ToDo> todoList = data
        .map(
          (e) => ToDo(
            index: e["id"] as int,
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
