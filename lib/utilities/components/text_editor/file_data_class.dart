/*
* File Name        : file_data_class.dart
* Group            : trOlsz Group
* Description      : This file contains code for FileData Class.
*/

class FileData {
  late int millisecondSinceEpoch;
  late String title;
  late String content;
  late String modifiedAt;
  late String createdAt;
  late String reactionType;

  FileData({
    required this.millisecondSinceEpoch,
    required this.title,
    required this.content,
    required this.modifiedAt,
    required this.createdAt,
    required this.reactionType,
  });
}
