/*
* File Name        : streak_calender.dart
* Group            : trOlsz Group
* Description      : This file contains code for our streak calender.
*/

import 'dart:io';

import 'package:chronicles/utilities/data/user_auth_data.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:streak_calendar/streak_calendar.dart';
import 'package:sqflite/sqflite.dart';

class StreakCalender extends StatefulWidget {
  const StreakCalender({super.key});

  @override
  State<StreakCalender> createState() => _StreakCalenderState();
}

class _StreakCalenderState extends State<StreakCalender> {
  List<DateTime> listStreakDates = [];
  Database? _database;

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  static Future<Directory> _getAppDocumentsDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory;
  }

  Future<void> initDatabase() async {
    String userId = await UserDataFetcher().fetchUID();

    Directory appDocDir = await _getAppDocumentsDirectory();
    String streakDB =
        '${appDocDir.path}/$userId/${getDatabasesPath()}/streaks.db';

    _database = await openDatabase(
      streakDB,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE streaks(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT UNIQUE)",
        );
      },
      version: 1,
    );

    await loadStreakDates();
    await didUserLogin();
  }

  Future<void> loadStreakDates() async {
    if (_database == null) return;

    final List<Map<String, dynamic>> results =
        await _database!.query('streaks');

    setState(() {
      listStreakDates = results
          .map((e) => DateTime.parse(e['date'])) // Convert string to DateTime
          .toList();
    });
  }

  Future<void> didUserLogin() async {
    if (_database == null) return;

    String today = DateTime.now().toIso8601String().split('T')[0];

    List<Map<String, dynamic>> result = await _database!.query(
      'streaks',
      where: 'date = ?',
      whereArgs: [today],
    );

    if (result.isEmpty) {
      await _database!.insert(
        'streaks',
        {'date': today},
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

      setState(() {
        listStreakDates.add(DateTime.now());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CleanCalendar(
      enableDenseViewForDates: true,
      enableDenseSplashForDates: true,
      datesForStreaks: listStreakDates,
      currentDateProperties: DatesProperties(
        datesDecoration: DatesDecoration(
          datesBorderRadius: 1000,
          datesBackgroundColor: Color(0xFFFFFFFF),
          datesBorderColor: Color(0xFFFFFFFF),
          datesTextColor: Color(0xFF1F1F1F),
        ),
      ),
      generalDatesProperties: DatesProperties(
        datesDecoration: DatesDecoration(
          datesBorderRadius: 1000,
          datesBackgroundColor: Color(0xFFFFFFFF),
          datesBorderColor: Color(0xFFFFFFFF),
          datesTextColor: Color(0xFF1F1F1F),
        ),
      ),
      streakDatesProperties: DatesProperties(
        datesDecoration: DatesDecoration(
          datesBorderRadius: 1000,
          datesBackgroundColor: Color(0xFF4EABCC), // Blue streak color
          datesBorderColor: Colors.transparent,
          datesTextColor: Color(0xFFFFFFFF),
        ),
      ),
      leadingTrailingDatesProperties: DatesProperties(
        disable: true,
        hide: true,
        datesDecoration: DatesDecoration(
          datesBorderRadius: 1000,
          datesBackgroundColor: Color(0x104EABCC),
          datesBorderColor: Colors.transparent,
          datesTextColor: Color(0xFF1F1F1F),
        ),
      ),
    );
  }
}
