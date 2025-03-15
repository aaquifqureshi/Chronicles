/*
* File Name        : streak_calender.dart
* Group            : trOlsz Group
* Description      : This file contains code for our streak calender.
*/

import 'package:flutter/material.dart';
import 'package:streak_calendar/streak_calendar.dart';
import 'package:chronicles/services/streak_services.dart';

class StreakCalender extends StatefulWidget {
  const StreakCalender({super.key});

  @override
  State<StreakCalender> createState() => _StreakCalenderState();
}

class _StreakCalenderState extends State<StreakCalender> {
  List<DateTime> listStreakDates = [];

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  Future<void> initDatabase() async {
    await loadStreakDates();
    await didUserLogin();
  }

  Future<void> loadStreakDates() async {
    List<DateTime> streakDates =
        await StreakDatabaseService.instance.loadStreakDates();
    setState(() {
      listStreakDates = streakDates;
    });
  }

  Future<void> didUserLogin() async {
    String today = DateTime.now().toIso8601String().split('T')[0];
    await StreakDatabaseService.instance.addStreakDate(today);

    setState(() {
      listStreakDates.add(DateTime.now());
    });
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
