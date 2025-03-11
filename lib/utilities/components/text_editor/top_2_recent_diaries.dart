import 'package:chronicles/services/file_database.dart';
import 'package:flutter/material.dart';
import 'FileData.dart';
import 'chronicles_text_editor.dart';
import 'package:intl/intl.dart';

class Top2RecentDiaries extends StatefulWidget {
  const Top2RecentDiaries({super.key});

  @override
  State<Top2RecentDiaries> createState() => _Top2RecentDiariesState();
}

class _Top2RecentDiariesState extends State<Top2RecentDiaries> {
  List<FileData> fileData = [];
  List<Container> top3Files = [];

  final FileDatabase _fileDB = FileDatabase.instance;

  void _loadFileData() async {
    fileData = await _fileDB.fetchTop3Files();

    setState(() {
      top3Files = fileData.asMap().entries.map((entry) {
        int index = entry.key;

        FileData file = entry.value;

        Color containerColor = _getColorByIndex(index);

        String modifiedDate = file.modifiedAt ?? '';

        modifiedDate = modifiedDate
            .replaceAll("Tues", "Tue")
            .replaceAll("Thurs", "Thu")
            .replaceAll("June", "Jun")
            .replaceAll("July", "Jul")
            .replaceAll("Sept", "Sep")
            .trim();

        String displayDate = " ";

        try {
          DateTime formatDate =
              DateFormat("EEE, dd-MMM-yyyy").parseStrict(modifiedDate);

          displayDate = DateFormat("EEEE,\ndd MMMM yyyy").format(formatDate);
        } catch (e) {
          print("Error formatting date: $modifiedDate");
        }

        return Container(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TextEditor(
                    fileName: '${file.millisecondSinceEpoch}.json',
                    isModify: true,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 9.0, left: 9.0),
              padding: EdgeInsets.all(10.0),
              width: 140.0,
              height: 180.0,
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayDate ?? '',
                    style: TextStyle(
                      fontFamily: "Hind",
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                      color: Color(0x801F1F1F),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                    child: Text(
                      file.title ?? '',
                      style: TextStyle(
                        fontFamily: "hind",
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Color(0xFF1F1F1F),
                      ),
                    ),
                  ),
                  Text(
                    file.content,
                    style: TextStyle(
                      fontFamily: "Hind",
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Color(0xFF1F1F1F),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList();
    });
  }

  Color _getColorByIndex(int index) {
    List<Color> colors = [
      Color(0xFFD7EFF6),
      Color(0xFFB4E0ED),
      Color(0xFFDAF4FA),
    ];

    return colors[index % colors.length];
  }

  @override
  void initState() {
    super.initState();
    _loadFileData();
  }

  @override
  Widget build(BuildContext context) {
    if (top3Files.isEmpty) {
      return Container(
        height: double.minPositive,
        child: Center(
          child: Text(
            'No Recent Files!!!',
            style: TextStyle(
              fontFamily: "Hind",
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Color(0x40000000),
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: top3Files,
      ),
    );
  }
}
