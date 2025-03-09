class CurrentDateTime {
  final now = DateTime.now();

  int getMilliSecondSinceEpoch() {
    return now.millisecondsSinceEpoch;
  }

  DateTime convertMilliSecondsSinceEpochToDateTime(int milliSecondsSinceEpoch) {
    return DateTime.fromMillisecondsSinceEpoch(milliSecondsSinceEpoch);
  }

  int getCurrentDay() {
    return now.day;
  }

  int getCurrentYear() {
    return now.year;
  }

  String getCurrentWeekDay() {
    late String weekday;
    switch (now.weekday) {
      case 1:
        weekday = 'Mon';
        break;
      case 2:
        weekday = 'Tues';
        break;
      case 3:
        weekday = 'Wed';
        break;
      case 4:
        weekday = 'Thru';
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

  String getCurrentMonth() {
    late String month;
    switch (now.month) {
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
        month = 'June';
        break;
      case 7:
        month = 'July';
        break;
      case 8:
        month = 'Aug';
        break;
      case 9:
        month = 'Sept';
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
}

String getStringMonth(int m) {
  late String month;
  switch (m) {
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
      month = 'June';
      break;
    case 7:
      month = 'July';
      break;
    case 8:
      month = 'Aug';
      break;
    case 9:
      month = 'Sept';
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

String stringWeekDay(int w) {
  late String weekday;
  switch (w) {
    case 1:
      weekday = 'Mon';
      break;
    case 2:
      weekday = 'Tues';
      break;
    case 3:
      weekday = 'Wed';
      break;
    case 4:
      weekday = 'Thru';
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
