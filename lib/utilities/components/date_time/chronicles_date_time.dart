/*
* File Name        : chronicles_date_time.dart
* Group            : trOlsz Group
* Description      : This file contains code for our custom datetime.
*/

class ChroniclesDateTime {
  DateTime nowTime;

  ChroniclesDateTime({required this.nowTime});

  int getMilliSecondSinceEpoch() {
    return nowTime.millisecondsSinceEpoch;
  }

  DateTime convertMilliSecondsSinceEpochToDateTime(int milliSecondsSinceEpoch) {
    nowTime = DateTime.fromMillisecondsSinceEpoch(milliSecondsSinceEpoch);
    return nowTime;
  }

  int getIntDay() {
    return nowTime.day;
  }

  int getIntWeekday() {
    return nowTime.weekday;
  }

  int getIntMonth() {
    return nowTime.month;
  }

  int getIntYear() {
    return nowTime.year;
  }

  String getHalfStringWeekDay() {
    late String weekday;
    switch (nowTime.weekday) {
      case 1:
        weekday = 'Mon';
        break;
      case 2:
        weekday = 'Tue';
        break;
      case 3:
        weekday = 'Wed';
        break;
      case 4:
        weekday = 'Thu';
        break;
      case 5:
        weekday = 'Fri';
        break;
      case 6:
        weekday = 'Sat';
        break;
      case 7:
        weekday = 'Sun';
        break;
    }
    return weekday;
  }

  String getFullStringWeekDay() {
    late String weekday;
    switch (nowTime.weekday) {
      case 1:
        weekday = 'Monday';
        break;
      case 2:
        weekday = 'Tuesday';
        break;
      case 3:
        weekday = 'Wednesday';
        break;
      case 4:
        weekday = 'Thursday';
        break;
      case 5:
        weekday = 'Friday';
        break;
      case 6:
        weekday = 'Saturday';
        break;
      case 7:
        weekday = 'Sunday';
        break;
    }
    return weekday;
  }

  String getHalfStringMonth() {
    late String month;
    switch (nowTime.month) {
      case 1:
        month = 'Jan';
        break;
      case 2:
        month = 'Feb';
        break;
      case 3:
        month = 'Mar';
        break;
      case 4:
        month = 'Apr';
        break;
      case 5:
        month = 'May';
        break;
      case 6:
        month = 'Jun';
        break;
      case 7:
        month = 'Jul';
        break;
      case 8:
        month = 'Aug';
        break;
      case 9:
        month = 'Sep';
        break;
      case 10:
        month = 'Oct';
        break;
      case 11:
        month = 'Nov';
        break;
      case 12:
        month = 'Dec';
        break;
    }
    return month;
  }

  String getFullStringMonth() {
    late String month;
    switch (nowTime.month) {
      case 1:
        month = 'January';
        break;
      case 2:
        month = 'February ';
        break;
      case 3:
        month = 'March';
        break;
      case 4:
        month = 'April';
        break;
      case 5:
        month = 'May';
        break;
      case 6:
        month = 'June';
        break;
      case 7:
        month = 'July';
        break;
      case 8:
        month = 'August';
        break;
      case 9:
        month = 'September';
        break;
      case 10:
        month = 'October';
        break;
      case 11:
        month = 'November';
        break;
      case 12:
        month = 'December';
        break;
    }
    return month;
  }
}
