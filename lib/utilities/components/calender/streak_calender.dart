import 'package:flutter/material.dart';
import 'package:streak_calendar/streak_calendar.dart';

class StreakCalender extends StatefulWidget {
  StreakCalender({super.key});

  @override
  State<StreakCalender> createState() => _StreakCalenderState();
}

class _StreakCalenderState extends State<StreakCalender> {
  List<DateTime> streakDates = [];

  @override
  void initState() {
    super.initState();
  }

  void addDate(DateTime date) {
    setState(() {
      streakDates.add(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CleanCalendar(
      enableDenseViewForDates: true,
      enableDenseSplashForDates: true,
      datesForStreaks: [
        DateTime(2025, 2, 5),
        DateTime(2025, 2, 6),
        DateTime(2025, 2, 7),
        DateTime(2025, 2, 9),
        DateTime(2025, 2, 10),
        DateTime(2025, 2, 11),
        DateTime(2025, 2, 13),
        DateTime(2025, 2, 20),
        DateTime(2025, 2, 21),
        DateTime(2025, 2, 23),
        DateTime(2025, 2, 24),
      ],
      currentDateProperties: DatesProperties(
        datesDecoration: DatesDecoration(
          datesBorderRadius: 1000,
          datesBackgroundColor: Color(0x504EABCC),
          datesBorderColor: Color(0xFF111519),
          datesTextColor: Color(0xFF1F1F1F),
        ),
      ),
      generalDatesProperties: DatesProperties(
        datesDecoration: DatesDecoration(
          datesBorderRadius: 1000,
          datesBackgroundColor: Color(0x604EABCC),
          datesBorderColor: Color(0xFF111519),
          datesTextColor: Color(0xFF1F1F1F),
        ),
      ),
      streakDatesProperties: DatesProperties(
        datesDecoration: DatesDecoration(
          datesBorderRadius: 1000,
          datesBackgroundColor: Color(0xFF4EABCC),
          datesBorderColor: Color(0xFF111519),
          datesTextColor: Colors.white,
        ),
      ),
      leadingTrailingDatesProperties: DatesProperties(
        datesDecoration: DatesDecoration(
          datesBorderRadius: 1000,
          datesBackgroundColor: Color(0x104EABCC),
          datesBorderColor: Color(0x10111519),
          datesTextColor: Color(0xFF1F1F1F),
        ),
      ),
    );
  }
}
