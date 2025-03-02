import 'dart:convert';
import 'dart:io';
import 'package:chronicles/services/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chronicles/utilities/components/date_time/current_datetime.dart';
import 'package:path_provider/path_provider.dart';

import 'file_database.dart';

class FileManager {
  static const String _diaryFolderName = 'diary';

  static Future<Directory> _getAppDocumentsDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory;
  }

  static Future<void> saveFileAsJson(
      {required int milliSinceEpoch,
      required String title,
      required String createDate,
      required String modifyDate,
      required List<TextEditingController> controller}) async {
    SecureStorage storage = SecureStorage();
    String user_id = await storage.readSecureData('user_id');

    Directory appDocDir = await _getAppDocumentsDirectory();
    Directory diaryDir =
        Directory('${appDocDir.path}/$user_id/$_diaryFolderName');

    if (!await diaryDir.exists()) {
      await diaryDir.create(recursive: true);
    }
    String fileName = '$milliSinceEpoch.json';
    print(fileName);
    File file = File('${diaryDir.path}/$fileName');

    Map<String, dynamic> fileData = {
      'title': title,
      'createdAt': createDate,
      'modifiedAt': modifyDate,
      'controllers': controller.map((controller) => controller.text).toList(),
    };

    String jsonData = jsonEncode(fileData);

    await file.writeAsString(jsonData);
  }

  static Future<Map<String, dynamic>?> loadJsonFile(String fileName) async {
    SecureStorage storage = SecureStorage();
    String user_id = await storage.readSecureData('user_id');

    Directory appDocDir = await _getAppDocumentsDirectory();
    Directory diaryDir =
        Directory('${appDocDir.path}/$user_id/$_diaryFolderName');

    File file = File('${diaryDir.path}/$fileName');
    if (await file.exists()) {
      String jsonData = await file.readAsString();
      return jsonDecode(jsonData);
    } else {
      print("File does not exist!");
    }
    return null;
  }

  static Future<void> modifyJsonFile(
      {required String fileName,
      required String title,
      required String createDate,
      required String modifyDate,
      required List<TextEditingController> controller}) async {
    SecureStorage storage = SecureStorage();
    String user_id = await storage.readSecureData('user_id');

    Directory appDocDir = await _getAppDocumentsDirectory();
    Directory diaryDir =
        Directory('${appDocDir.path}/$user_id/$_diaryFolderName');

    if (!await diaryDir.exists()) {
      await diaryDir.create(recursive: true);
    }
    File file = File('${diaryDir.path}/$fileName');

    Map<String, dynamic> fileData = {
      'title': title,
      'createdAt': createDate,
      'modifiedAt': modifyDate,
      'controllers': controller.map((controller) => controller.text).toList(),
    };

    String jsonData = jsonEncode(fileData);

    await file.writeAsString(jsonData);
  }
}
