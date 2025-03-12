/*
* File Name        : box_search_bar.dart
* Group            : trOlsz Group
* Description      : This file contains code for custom search bar.
*/

import 'package:flutter/material.dart';

class BoxSearchBar extends StatefulWidget {
  const BoxSearchBar({super.key});

  @override
  State<BoxSearchBar> createState() => _BoxSearchBarState();
}

class _BoxSearchBarState extends State<BoxSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: "Search",
      hintStyle: WidgetStateProperty.all<TextStyle>(
        TextStyle(
          fontSize: 16.0,
          fontFamily: 'Hind',
          fontWeight: FontWeight.w400,
          color: Color(0xFF1F1F1F),
        ),
      ),
      leading: Icon(Icons.search, color: Color(0xFF1F1F1F)),
      backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
      shadowColor: WidgetStateProperty.all<Color>(Color(0xFF344A53)),
      elevation: WidgetStateProperty.all<double>(2),
      padding:
          WidgetStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(22, 0, 0, 0)),
      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
    );
  }
}
