import 'package:flutter/material.dart';

import 'package:chronicles/services/file_database.dart';
import 'FileData.dart';

class ListAllDiaries extends StatefulWidget {
  const ListAllDiaries({super.key});

  @override
  State<ListAllDiaries> createState() => _ListAllDiariesState();
}

class _ListAllDiariesState extends State<ListAllDiaries> {
  List<FileData> allDiaries = [];

  final FileDatabase _fileDB = FileDatabase.instance;

  Future<void> _loadAllDiaries() async {
    allDiaries = await _fileDB.fetchFiles();
    groupFiles();
  }

  void groupFiles() {}

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
          Text("Personal Notes"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text("Productive"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Weekday"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
