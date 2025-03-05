import 'package:chronicles/services/file_database.dart';
import 'package:flutter/material.dart';
import 'FileData.dart';
import 'chronicles_text_editor.dart';

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
      top3Files = fileData.map((file) {
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
              margin: EdgeInsets.all(10.0),
              color: Color(0x104EABCC),
              child: Column(
                children: [
                  Text(file.title ?? ''),
                  Text(file.modifiedAt ?? ''),
                  Text(file.content),
                ],
              ),
            ),
          ),
        );
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFileData();
  }

  @override
  Widget build(BuildContext context) {
    if (top3Files.isEmpty) {
      return Center(
        child: Text('No Recent Files!!!'),
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
