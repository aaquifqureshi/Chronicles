/*
* File Name        : streak_services.dart
* Group            : trOlsz Group
* Description      : This file is responsible for managing all database
*                    related queries like storing, retrieving, and deleting
*                    for Streak Calendar functionality.
*/

import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:chronicles/utilities/data/user_auth_data.dart';

class StreakDatabaseService {
  static Database? _db;
  static final StreakDatabaseService instance =
      StreakDatabaseService._constructor();

  StreakDatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDatabase();
    return _db!;
  }

  static Future<Directory> _getAppDocumentsDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory;
  }

  Future<Database> _initDatabase() async {
    String userId = await UserDataFetcher().fetchUID();

    Directory appDocDir = await _getAppDocumentsDirectory();
    String streakDBPath =
        '${appDocDir.path}/$userId/${getDatabasesPath()}/streaks.db';

    final database = await openDatabase(
      streakDBPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE streaks(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT UNIQUE)",
        );
      },
    );
    return database;
  }

  Future<List<DateTime>> loadStreakDates() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query('streaks');
    return results.map((e) => DateTime.parse(e['date'])).toList();
  }

  Future<void> addStreakDate(String today) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'streaks',
      where: 'date = ?',
      whereArgs: [today],
    );

    if (result.isEmpty) {
      await db.insert(
        'streaks',
        {'date': today},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  Future<int> calculateCurrentStreak() async {
    List<DateTime> streakDates = await loadStreakDates();

    if (streakDates.isEmpty) {
      return 0;
    }

    streakDates.sort();

    int currentStreak = 1;

    for (int i = streakDates.length - 1; i > 0; i--) {
      if (streakDates[i].difference(streakDates[i - 1]).inDays == 1) {
        currentStreak++;
      } else {
        break;
      }
    }

    return currentStreak;
  }

  Future<int> calculateMaxStreak() async {
    List<DateTime> streakDates = await loadStreakDates();

    if (streakDates.isEmpty) {
      return 0;
    }

    streakDates.sort();

    int maxStreak = 1;
    int currentStreak = 1;

    for (int i = 1; i < streakDates.length; i++) {
      if (streakDates[i].difference(streakDates[i - 1]).inDays == 1) {
        currentStreak++;
      } else {
        maxStreak = currentStreak > maxStreak ? currentStreak : maxStreak;
        currentStreak = 1;
      }
    }

    maxStreak = currentStreak > maxStreak ? currentStreak : maxStreak;

    return maxStreak;
  }
}
