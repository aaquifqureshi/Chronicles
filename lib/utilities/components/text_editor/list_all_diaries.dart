import 'package:chronicles/utilities/components/date_time/current_datetime.dart';
import 'package:chronicles/utilities/components/text_editor/chronicles_text_editor.dart';
import 'package:flutter/material.dart';

import 'package:chronicles/services/file_database.dart';
import 'FileData.dart';

TextStyle pageTitleStyle = TextStyle(
  fontFamily: 'Hind',
  fontWeight: FontWeight.w700,
  fontSize: 28.0,
  color: Color(0xFF1F1F1F),
);

TextStyle monthYearStyling = TextStyle(
  fontFamily: 'Hind',
  fontWeight: FontWeight.w500,
  fontSize: 24.0,
  color: Color(0xFF1F1F1F),
);

TextStyle weekdayStyle = TextStyle(
  fontFamily: 'Hind',
  fontWeight: FontWeight.w500,
  fontSize: 24.0,
  color: Color(0xFF1F1F1F),
);

TextStyle intDayStyle = TextStyle(
  fontFamily: 'Hind',
  fontWeight: FontWeight.w600,
  fontSize: 34.0,
  color: Color(0xFF1F1F1F),
);

TextStyle diaryTitleStyle = TextStyle(
  fontFamily: 'Hind',
  fontWeight: FontWeight.w500,
  fontSize: 16.0,
  color: Color(0xFF1F1F1F),
);

TextStyle diaryContentStyle = TextStyle(
  fontFamily: 'Hind',
  fontWeight: FontWeight.w400,
  fontSize: 16.0,
  color: Color(0xFF1F1F1F),
);

TextStyle diaryModifiedAtStyle = TextStyle(
  fontFamily: 'Hind',
  fontWeight: FontWeight.w400,
  fontSize: 16.0,
  color: Color(0x601F1F1F),
);

class ListAllDiaries extends StatefulWidget {
  const ListAllDiaries({super.key});

  @override
  State<ListAllDiaries> createState() => _ListAllDiariesState();
}

class _ListAllDiariesState extends State<ListAllDiaries> {
  List<FileData> allDiaries = [];
  Map<String, Map<String, List<FileData>>> groupData = {};

  final FileDatabase _fileDB = FileDatabase.instance;

  Future<void> _loadAllDiaries() async {
    allDiaries = await _fileDB.fetchFiles();
    groupFiles();
  }

  void groupFiles() {
    Map<String, Map<String, List<FileData>>> tempGroupData = {};

    for (var diary in allDiaries) {
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(diary.millisecondSinceEpoch);
      String month = getStringMonth(dateTime.month);
      String year = '${dateTime.year}';
      String monthYear = '$month-$year';

      String day = '${stringWeekDay(dateTime.weekday)}-${dateTime.day}';

      if (!tempGroupData.containsKey(monthYear)) {
        tempGroupData[monthYear] = {};
      }

      if (!tempGroupData[monthYear]!.containsKey(day)) {
        tempGroupData[monthYear]![day] = [];
      }
      tempGroupData[monthYear]![day]!.add(diary);
    }
    setState(() {
      groupData = tempGroupData;
    });
  }

  @override
  void initState() {
    _loadAllDiaries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Personal Notes",
            style: pageTitleStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0),
                  color: Color(0x00000080),
                ),
                child: Text("Productive"),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0),
                  color: Color(0x00000080),
                ),
                child: Text("Weekday"),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            color: Color(0xFFC1CCD6),
            height: 20.0,
            thickness: 4.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: groupData.keys.length,
              itemBuilder: (context, index) {
                String monthYear = groupData.keys.elementAt(index);
                Map<String, List<FileData>> monthlyFiles =
                    groupData.values.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          monthYear,
                          style: monthYearStyling,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: monthlyFiles.keys.length,
                        itemBuilder: (context, index) {
                          String day = monthlyFiles.keys.elementAt(index);
                          String weekday = day.split('-').first;
                          String intday = day.split('-').last;
                          List<FileData> dayDiaries =
                              monthlyFiles.values.elementAt(index);
                          List<Widget> dayDiariesWidget = [];
                          for (var diary in dayDiaries) {
                            dayDiariesWidget.add(
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TextEditor(
                                              fileName:
                                                  '${diary.millisecondSinceEpoch}.json',
                                              isModify: true,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Text(diary.title,
                                              style: diaryTitleStyle),
                                          Text(
                                            diary.content,
                                            style: diaryContentStyle,
                                          ),
                                          Text(
                                            diary.modifiedAt,
                                            style: diaryModifiedAtStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (dayDiaries.last != diary)
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          color: Color(0xFFC1CCD6),
                                          height: 1,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              200,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          weekday,
                                          style: weekdayStyle,
                                        ),
                                        Text(
                                          intday,
                                          style: intDayStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 10.0, bottom: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: dayDiariesWidget,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 20.0,
                                ),
                                child: Divider(
                                  color: Color(0xFFC1CCD6),
                                  thickness: 3.0,
                                  height: 5.0,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
