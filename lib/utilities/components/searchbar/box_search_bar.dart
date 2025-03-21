import 'package:chronicles/screens/todo/todo_screen.dart';
import 'package:chronicles/services/search_in_device.dart';
import 'package:chronicles/utilities/components/date_time/chronicles_date_time.dart';
import 'package:flutter/material.dart';
import 'package:chronicles/utilities/components/text_editor/file_data_class.dart';
import 'package:chronicles/screens/text_editor/chronicles_text_editor.dart';

import '../todo/todo.dart';

TextStyle searchTitles = TextStyle(
  color: Color(0xFF1F1F1F),
  fontFamily: 'Hind',
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
);
TextStyle searchTypes = TextStyle(
  color: Color(0x801F1F1F),
  fontFamily: 'Hind',
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
);
TextStyle searchDateTimes = TextStyle(
  color: Color(0x801F1F1F),
  fontFamily: 'Hind',
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
);

class BoxSearchBar extends StatefulWidget {
  const BoxSearchBar({super.key});

  @override
  State<BoxSearchBar> createState() => _BoxSearchBarState();
}

class _BoxSearchBarState extends State<BoxSearchBar> {
  List<ToDo> todoSuggestions = [];
  List<FileData> diarySuggestions = [];
  SearchService searchService = SearchService();

  void fetchSuggestion(String input) async {
    todoSuggestions = await searchService.getTodoSuggestions(input);
    diarySuggestions = await searchService.getDiarySuggestions(input);
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      viewBackgroundColor: Color(0xFFFFFFFF),
      barHintText: "Search",
      barHintStyle: WidgetStateProperty.all<TextStyle>(
        TextStyle(
          fontSize: 16.0,
          fontFamily: 'Hind',
          fontWeight: FontWeight.w400,
          color: Color(0xFF1F1F1F),
        ),
      ),
      barLeading: Icon(Icons.search, color: Color(0xFF1F1F1F)),
      barBackgroundColor: WidgetStateProperty.all<Color>(Colors.white),
      barPadding:
          WidgetStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(22, 0, 0, 0)),
      barShape: WidgetStatePropertyAll<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      onChanged: (input) {
        setState(() {
          fetchSuggestion(input.toLowerCase());
        });
      },
      isFullScreen: false,
      onSubmitted: (query) {
        if (query.isEmpty) {
          Navigator.pop(context);
        }
        fetchSuggestion(query.toLowerCase());
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        final String input = controller.value.text;

        if (input.isEmpty) {
          return [];
        }

        List<Widget> suggestions = [];

        suggestions.addAll(todoSuggestions.map((suggestion) {
          ChroniclesDateTime dateTime = ChroniclesDateTime(
              nowTime: DateTime.fromMillisecondsSinceEpoch(
                  suggestion.millisecondSinceEpoch));
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  suggestion.content,
                  style: searchTitles,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '::Todo::',
                      style: searchTypes,
                    ),
                    Text(
                      '${dateTime.getIntDay()} - ${dateTime.getFullStringMonth()} - ${dateTime.getIntYear()}',
                      style: searchDateTimes,
                    ),
                  ],
                )
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ToDoScreen();
                  },
                ),
              );
            },
          );
        }).toList());

        suggestions.addAll(diarySuggestions.map(
          (suggestion) {
            ChroniclesDateTime dateTime = ChroniclesDateTime(
                nowTime: DateTime.fromMillisecondsSinceEpoch(
                    suggestion.millisecondSinceEpoch));
            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    suggestion.title,
                    style: searchTitles,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '::Diary::',
                        style: searchTypes,
                      ),
                      Text(
                        '${dateTime.getIntDay()} - ${dateTime.getFullStringMonth()} - ${dateTime.getIntYear()}',
                        style: searchDateTimes,
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TextEditor(
                        isModify: true,
                        fileName: '${suggestion.millisecondSinceEpoch}.json',
                      );
                    },
                  ),
                );
              },
            );
          },
        ).toList());

        return suggestions;
      },
    );
  }
}
