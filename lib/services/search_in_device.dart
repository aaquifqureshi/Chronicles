/*
* File Name        : search_in_device.dart
* Group            : trOlsz Group
* Description      : This file is has code for Searching File Database,
*                    File Information, and all data stored.
*/

import 'package:chronicles/services/todo_services.dart';
import '../utilities/components/text_editor/file_data_class.dart';
import '../utilities/components/todo/todo.dart';
import 'file_database.dart';

class SearchService {
  final ToDoDatabaseService _todoService = ToDoDatabaseService.instance;
  final FileDatabase _fileService = FileDatabase.instance;

  Future<List<ToDo>> getTodoSuggestions(String input) async {
    List<ToDo> todoSuggestions = [];

    if (input.isNotEmpty) {
      List<ToDo> todos = await _todoService.fetchToDoTasks(isComplete: false);
      todoSuggestions = todos
          .where((todo) =>
              todo.content.toLowerCase().contains(input.toLowerCase()))
          .toList();
    }
    return todoSuggestions;
  }

  Future<List<FileData>> getDiarySuggestions(String input) async {
    List<FileData> diarySuggestions = [];

    if (input.isNotEmpty) {
      List<FileData> files = await _fileService.fetchFiles();
      diarySuggestions = files
          .where(
              (file) => file.title.toLowerCase().contains(input.toLowerCase()))
          .toList();
    }
    return diarySuggestions;
  }
}
