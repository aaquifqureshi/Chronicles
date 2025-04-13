import 'package:chronicles/screens/text_editor/chronicles_text_editor.dart';
import 'package:chronicles/services/file_database.dart';
import 'package:chronicles/utilities/components/date_time/chronicles_date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:chronicles/services/streak_services.dart';

import '../../data/user_auth_data.dart';
import '../text_editor/file_data_class.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';

import '../text_editor/reaction_type_data.dart';

TextStyle monthYearStyle = TextStyle(
  fontFamily: 'Hind',
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

class Calendar extends StatefulWidget {
  Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late DateTime currentDate;
  late List<DateTime> datesGrid;
  List<List<DateTime>> streakListOfDates = [];
  List<DateTime> streaks = [];
  int currentStreak = 0;
  int maxStreak = 0;
  int reactionAverage = 0;

  Future<void> initDatabase() async {
    await loadStreakDates();
    await didUserLogin();
  }

  Future<void> fetchStreak() async {
    int streakValueFromUserData = await UserDataFetcher().fetchStreak();
    int maxStreakValueFromUserData = await UserDataFetcher().fetchMaxStreak();

    int calculatedMaxStreak =
        await StreakDatabaseService.instance.calculateMaxStreak();
    int calculatedCurrentStreak =
        await StreakDatabaseService.instance.calculateCurrentStreak();

    setState(() {
      currentStreak = calculatedCurrentStreak > streakValueFromUserData
          ? calculatedCurrentStreak
          : streakValueFromUserData;

      maxStreak = calculatedMaxStreak > maxStreakValueFromUserData
          ? calculatedMaxStreak
          : maxStreakValueFromUserData;
    });
  }

  Future<void> loadStreakDates() async {
    List<DateTime> streakDates =
        await StreakDatabaseService.instance.loadStreakDates();
    setState(() {
      streaks = streakDates;
    });
    streakToList();
  }

  Future<void> didUserLogin() async {
    String today = DateTime.now().toIso8601String().split('T')[0];
    await StreakDatabaseService.instance.addStreakDate(today);

    setState(() {
      streaks.add(DateTime.now());
    });
  }

  void _changeMonth(int offset) {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month + offset);
      datesGrid = _generateDatesGrid(currentDate);
    });
  }

  List<DateTime> _generateDatesGrid(DateTime date) {
    int numDays = DateTime(date.year, date.month + 1, 0).day;
    int firstWeekday = DateTime(date.year, date.month, 1).weekday % 7;
    List<DateTime> dates = [];

    DateTime previousMonth = DateTime(date.year, date.month - 1);
    int previousMonthLastDay =
        DateTime(previousMonth.year, previousMonth.month + 1, 0).day;
    for (int i = firstWeekday; i > 0; i--) {
      dates.add(
        DateTime(
          previousMonth.year,
          previousMonth.month,
          previousMonthLastDay - i + 1,
        ),
      );
    }

    for (int day = 1; day <= numDays; day++) {
      dates.add(DateTime(date.year, date.month, day));
    }

    int remainingBoxes = 42 - dates.length; // 6 weeks * 7 days
    for (int day = 1; day <= remainingBoxes; day++) {
      dates.add(DateTime(date.year, date.month + 1, day));
    }

    return dates;
  }

  String _monthName(int monthNumber) {
    String monthName = '';

    switch (monthNumber) {
      case 1:
        monthName = 'January';
        break;
      case 2:
        monthName = 'February';
        break;
      case 3:
        monthName = 'March';
        break;
      case 4:
        monthName = 'April';
        break;
      case 5:
        monthName = 'May';
        break;
      case 6:
        monthName = 'June';
        break;
      case 7:
        monthName = 'July';
        break;
      case 8:
        monthName = 'August';
        break;
      case 9:
        monthName = 'September';
        break;
      case 10:
        monthName = 'October';
        break;
      case 11:
        monthName = 'November';
        break;
      case 12:
        monthName = 'December';
        break;
      default:
        monthName = '';
        break;
    }
    return monthName;
  }

  void streakToList() {
    List<List<DateTime>> streakList = [];

    if (streaks.isEmpty) {
      return;
    }
    streaks.sort();
    List<DateTime> currentStreak = [streaks[0]];
    for (int i = 1; i < streaks.length; i++) {
      if (streaks[i].difference(streaks[i - 1]).inDays == 1) {
        currentStreak.add(streaks[i]);
      } else {
        streakList.add(currentStreak);
        currentStreak = [streaks[i]];
      }
    }
    streakList.add(currentStreak);

    setState(() {
      streakListOfDates = streakList;
    });
  }

  int streakPosition(DateTime date) {
    for (var streak in streakListOfDates) {
      if (streak.contains(date)) {
        if (streak.length == 1) {
          return 1;
        } else {
          if (date == streak.first) {
            return 2;
          } else if (date == streak.last) {
            return 3;
          } else {
            return 4;
          }
        }
      }
    }
    return 0;
  }

  int fetchReactionValue(FileData file) {
    ReactionType reactionType = ReactionType.none;

    reactionType = ReactionType.values.firstWhere(
      (element) => element.toString() == file.reactionType,
      orElse: () => ReactionType.none,
    );

    if (reactionType == ReactionType.crying) {
      return 1;
    } else if (reactionType == ReactionType.sad) {
      return 2;
    } else if (reactionType == ReactionType.noSadNoHappy) {
      return 3;
    } else if (reactionType == ReactionType.smile) {
      return 4;
    } else if (reactionType == ReactionType.happy) {
      return 5;
    }
    return 0;
  }

  String fetchAverageIcon(int reactionAverage) {
    if (reactionAverage == 1) {
      return "assets/images/icons/reaction/crying.svg";
    } else if (reactionAverage == 2) {
      return "assets/images/icons/reaction/sad.svg";
    } else if (reactionAverage == 3) {
      return "assets/images/icons/reaction/normal.svg";
    } else if (reactionAverage == 4) {
      return "assets/images/icons/reaction/smile.svg";
    } else if (reactionAverage == 5) {
      return "assets/images/icons/reaction/happy.svg";
    }
    return "null";
  }

  String fetchCurrentIcon(FileData file) {
    int value = fetchReactionValue(file);

    reactionAverage = reactionAverage + value;

    if (value == 1) {
      return "assets/images/icons/reaction/crying.svg";
    } else if (value == 2) {
      return "assets/images/icons/reaction/sad.svg";
    } else if (value == 3) {
      return "assets/images/icons/reaction/normal.svg";
    } else if (value == 4) {
      return "assets/images/icons/reaction/smile.svg";
    } else if (value == 5) {
      return "assets/images/icons/reaction/happy.svg";
    }
    return "null";
  }

  @override
  void initState() {
    super.initState();
    initDatabase();
    currentDate = DateTime.now();
    datesGrid = _generateDatesGrid(currentDate);
    fetchStreak();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_monthName(currentDate.month)} ${currentDate.year}',
              style: monthYearStyle,
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  child: Lottie.asset(
                    width: double.minPositive + 50,
                    height: double.minPositive + 50,
                    currentStreak > 2
                        ? 'assets/lottie/streak_red.json'
                        : 'assets/lottie/streak_4eabcc.json',
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  child: Text(
                    '$currentStreak',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: currentStreak > 2
                          ? Color(0xFFFFFFFF)
                          : Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () async {
                    if (DateTime.now().month != currentDate.month ||
                        DateTime.now().year != currentDate.year) {
                      setState(() {
                        currentDate = DateTime.now();
                        datesGrid = _generateDatesGrid(currentDate);
                        streakToList();
                      });
                    } else {
                      showMonthPicker(context, onSelected: (month, year) {
                        setState(() {
                          currentDate = DateTime(year, month);
                          datesGrid = _generateDatesGrid(currentDate);
                          streakToList();
                        });
                      },
                          initialSelectedMonth: currentDate.month,
                          initialSelectedYear: currentDate.year,
                          firstEnabledMonth: 3,
                          lastEnabledMonth: 10,
                          firstYear: 2000,
                          lastYear: 2025,
                          selectButtonText: 'OK',
                          cancelButtonText: 'Cancel',
                          highlightColor: Color(0xFF4EABCC),
                          textColor: Color(0xFF1F1F1F),
                          contentBackgroundColor: Colors.white,
                          dialogBackgroundColor: Colors.white);
                    }
                  },
                  icon: DateTime.now().month != currentDate.month ||
                          DateTime.now().year != currentDate.year
                      ? Icon(
                          Icons.calendar_today_rounded,
                          color: Color(0xFF4EABCC),
                        )
                      : Icon(
                          Icons.calendar_month_rounded,
                          color: Color(0xFF4EABCC),
                        ),
                ),
                IconButton(
                  onPressed: () {
                    _changeMonth(-1);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Color(0xFF4EABCC),
                    size: 20.0,
                  ),
                ),
                SizedBox(width: 10.0),
                IconButton(
                  onPressed: () {
                    _changeMonth(1);
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xFF4EABCC),
                    size: 20.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Gap(12),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              List<String> weekdayNames = [
                'Sun',
                'Mon',
                'Tue',
                'Wed',
                'Thu',
                'Fri',
                'Sat',
              ];
              return Text(
                weekdayNames[index],
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xFF1F1F1F),
                ),
              );
            }),
          ),
        ),
        Divider(color: Color(0x25000000), thickness: 2.0),
        const Gap(12),
        Flexible(
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.0,
            ),
            itemCount: datesGrid.length,
            itemBuilder: (context, index) {
              DateTime date = datesGrid[index];
              bool isCurrentMonth = date.month == currentDate.month;
              bool isStreak = false;
              bool isSingleStreak = false;
              bool isMiddleStreak = false;
              bool isFirstInStreak = false;
              bool isLastInStreak = false;
              int streakPos = streakPosition(date);

              if (streakPos == 1) {
                isSingleStreak = true;
              } else if (streakPos == 2) {
                isFirstInStreak = true;
              } else if (streakPos == 3) {
                isLastInStreak = true;
              } else if (streakPos == 4) {
                isMiddleStreak = true;
              }

              if (streakPos != 0) {
                isStreak = true;
              }

              return GestureDetector(
                onTap: () async {
                  ChroniclesDateTime cDate = ChroniclesDateTime(nowTime: date);
                  String weekday = cDate.getHalfStringWeekDay();
                  int day = cDate.getIntDay();
                  String month = cDate.getHalfStringMonth();
                  int year = cDate.getIntYear();
                  String createdAt = '$weekday, $day-$month-$year';

                  List<FileData> files = [];
                  List<FileData> getFiles =
                      await FileDatabase.instance.fetchFilesByDate(createdAt);

                  setState(() {
                    files = getFiles;
                  });

                  showDialog(
                    context: context,
                    builder: (context) {
                      reactionAverage = 0;
                      int localAverage = 0;
                      int fileCount = 0;
                      int value;
                      for (var file in files) {
                        value = fetchReactionValue(file);
                        if (value != 0) {
                          fileCount++;
                        }
                        localAverage += value;
                      }

                      if (fileCount != 0) {
                        reactionAverage = (localAverage / fileCount).round();
                      }

                      return Dialog(
                        backgroundColor: Color(0xFFFFFFFF),
                        insetPadding: EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 200,
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${date.day} - ${_monthName(date.month)} - ${date.year}',
                                        style: TextStyle(
                                          fontFamily: 'Hind',
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SvgPicture.asset(
                                        fetchAverageIcon((reactionAverage)),
                                        semanticsLabel: 'Dart Logo',
                                      ),
                                    ],
                                  ),
                                ),
                                DefaultTabController(
                                  length: 2,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TabBar(
                                        labelColor: Color(0xFF4EABCC),
                                        unselectedLabelColor: Color(0xFF1F1F1F),
                                        labelStyle: TextStyle(
                                          fontFamily: 'Hind',
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        unselectedLabelStyle: TextStyle(
                                          fontFamily: 'Hind',
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        indicator: UnderlineTabIndicator(
                                          borderSide: BorderSide(
                                            width: 3.0,
                                            color: Color(0xFF4EABCC),
                                          ),
                                          insets: EdgeInsets.symmetric(
                                              horizontal: 50.0),
                                        ),
                                        indicatorColor: Color(0xFF4EABCC),
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        dividerColor: Color(0xFF1F1F1F),
                                        dividerHeight: 3.0,
                                        tabs: [
                                          Tab(text: 'Diary'),
                                          Tab(text: 'ToDo'),
                                        ],
                                      ),
                                      Container(
                                        height: 350,
                                        child: TabBarView(
                                          children: [
                                            Center(
                                              child: files.isEmpty
                                                  ? Center(
                                                      child: Text(
                                                          'No Instance of your Chronicles on this date.'),
                                                    )
                                                  : ListView.builder(
                                                      itemCount: files.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Column(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                                      return TextEditor(
                                                                        isModify:
                                                                            true,
                                                                        fileName:
                                                                            '${files[index].millisecondSinceEpoch}.json',
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                              },
                                                              child: ListTile(
                                                                title: Text(
                                                                  files[index]
                                                                      .title,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Hind',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        18.0,
                                                                    color: Color(
                                                                        0xFF1F1F1F),
                                                                  ),
                                                                ),
                                                                subtitle: Text(
                                                                  files[index]
                                                                      .content,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Hind',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        16.0,
                                                                    color: Color(
                                                                        0xFF1F1F1F),
                                                                  ),
                                                                ),
                                                                trailing:
                                                                    SvgPicture
                                                                        .asset(
                                                                  fetchCurrentIcon(
                                                                      files[
                                                                          index]),
                                                                  semanticsLabel:
                                                                      'Dart Logo',
                                                                ),
                                                              ),
                                                            ),
                                                            if (index !=
                                                                files.length -
                                                                    1)
                                                              Divider(
                                                                thickness: 0.5,
                                                                color: Color(
                                                                    0xFF1F1F1F),
                                                              )
                                                          ],
                                                        );
                                                      },
                                                    ),
                                            ),
                                            Center(
                                              child: Text(
                                                  'ToDo Work in Progress...'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 6.0),
                      decoration: BoxDecoration(
                        color:
                            isSingleStreak || isFirstInStreak || isLastInStreak
                                ? Color(0xFF4EABCC)
                                : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Container(),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 6.0,
                        bottom: 6.0,
                        left: isFirstInStreak ? 9.0 : 0.0,
                        right: isLastInStreak ? 9.0 : 0.0,
                      ),
                      decoration: BoxDecoration(
                          shape: isSingleStreak
                              ? BoxShape.circle
                              : BoxShape.rectangle,
                          borderRadius: isSingleStreak
                              ? null
                              : BorderRadius.horizontal(
                                  left: isFirstInStreak
                                      ? Radius.circular(50.0) // Rounded left
                                      : Radius.zero,
                                  right: isLastInStreak
                                      ? Radius.circular(50.0) // Rounded right
                                      : Radius.zero,
                                ),
                          color: isStreak
                              ? isSingleStreak
                                  ? Color(0xFF4EABCC)
                                  : Color(0x504EABCC)
                              : Colors.transparent),
                      child: Center(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: isCurrentMonth
                                  ? isStreak
                                      ? isSingleStreak
                                          ? Color(0xFFFFFFFF)
                                          : isFirstInStreak || isLastInStreak
                                              ? Color(0xFFFFFFFF)
                                              : Color(0xFF1F1F1F)
                                      : Color(0xFF1F1F1F)
                                  : isStreak
                                      ? isSingleStreak
                                          ? Color(0xFFFFFFFF)
                                          : isFirstInStreak || isLastInStreak
                                              ? Color(0xFFFFFFFF)
                                              : Color(0xFF1F1F1F)
                                      : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
