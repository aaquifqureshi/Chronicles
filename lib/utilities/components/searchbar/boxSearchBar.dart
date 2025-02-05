import 'package:flutter/material.dart';

class BoxSearchBar extends StatefulWidget {
  const BoxSearchBar({super.key});

  @override
  State<BoxSearchBar> createState() => _BoxSearchBarState();
}

class _BoxSearchBarState extends State<BoxSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SearchBar();
  }
}
