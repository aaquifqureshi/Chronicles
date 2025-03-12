/*
* File Name        : todo.dart
* Group            : trOlsz Group
* Description      : This file contains code for ToDo Class.
*/

class ToDo {
  late int id;
  late int index;
  late String content;
  late int status;
  late int millisecondSinceEpoch;

  ToDo(
      {required this.id,
      required this.index,
      required this.content,
      required this.status,
      required this.millisecondSinceEpoch});
}
