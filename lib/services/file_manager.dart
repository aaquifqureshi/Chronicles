/*
* File Name        : file_manager.dart
* Group            : trOlsz Group
* Description      : This file is has code for all text editor aka
*                    diary related file operations like Saving a file,
*                    loading a file, deleting a file (AS JSON).
*/

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:chronicles/utilities/data/user_auth_data.dart';

class FileManager {
  static const String _diaryFolderName = 'diary';
  static const String _diaryImageFolderName = 'diaryImages';

  static Future<Directory> _getAppDocumentsDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory;
  }

  static Future<void> saveFileAsJson({
    required int milliSinceEpoch,
    required String title,
    required String createDate,
    required String modifyDate,
    required List<TextEditingController> controller,
    required String reactionType,
  }) async {
    String userId = await UserDataFetcher().fetchUID();

    Directory appDocDir = await _getAppDocumentsDirectory();
    Directory diaryDir =
        Directory('${appDocDir.path}/$userId/$_diaryFolderName');

    if (!await diaryDir.exists()) {
      await diaryDir.create(recursive: true);
    }
    String fileName = '$milliSinceEpoch.json';
    File file = File('${diaryDir.path}/$fileName');

    Map<String, dynamic> fileData = {
      'title': title,
      'createdAt': createDate,
      'modifiedAt': modifyDate,
      'controllers': controller.map((controller) => controller.text).toList(),
      'reaction': reactionType,
    };

    String jsonData = jsonEncode(fileData);

    await file.writeAsString(jsonData);
  }

  static Future<Map<String, dynamic>?> loadJsonFile(String fileName) async {
    String userId = await UserDataFetcher().fetchUID();

    Directory appDocDir = await _getAppDocumentsDirectory();
    Directory diaryDir =
        Directory('${appDocDir.path}/$userId/$_diaryFolderName');

    File file = File('${diaryDir.path}/$fileName');
    if (await file.exists()) {
      String jsonData = await file.readAsString();
      return jsonDecode(jsonData);
    } else {}
    return null;
  }

  static Future<void> modifyJsonFile({
    required String fileName,
    required String title,
    required String createDate,
    required String modifyDate,
    required List<TextEditingController> controller,
    required String reactionType,
  }) async {
    String userId = await UserDataFetcher().fetchUID();

    Directory appDocDir = await _getAppDocumentsDirectory();
    Directory diaryDir =
        Directory('${appDocDir.path}/$userId/$_diaryFolderName');

    if (!await diaryDir.exists()) {
      await diaryDir.create(recursive: true);
    }
    File file = File('${diaryDir.path}/$fileName');

    Map<String, dynamic> fileData = {
      'title': title,
      'createdAt': createDate,
      'modifiedAt': modifyDate,
      'controllers': controller.map((controller) => controller.text).toList(),
      'reaction': reactionType,
    };

    String jsonData = jsonEncode(fileData);

    await file.writeAsString(jsonData);
  }

  static Future<void> deleteJsonFile({required String fileName}) async {
    String userId = await UserDataFetcher().fetchUID();

    Directory appDocDir = await _getAppDocumentsDirectory();
    Directory diaryDir =
        Directory('${appDocDir.path}/$userId/$_diaryFolderName');

    if (!await diaryDir.exists()) {
      await diaryDir.create(recursive: true);
    }
    File file = File('${diaryDir.path}/$fileName');

    if (await file.exists()) {
      try {
        await file.delete();
      } catch (e) {
        print('File Not Deleted');
      }
    } else {
      print('File Not Found');
    }
  }

  static Future<String> saveImageFile(
      {required String filename,
      required XFile image,
      required String imageName}) async {
    String userId = await UserDataFetcher().fetchUID();

    Directory appDocDir = await _getAppDocumentsDirectory();
    Directory diaryImageDir = Directory(
        '${appDocDir.path}/$userId/$_diaryImageFolderName/${filename.split('.').first}');
    File imageFile = File('${diaryImageDir.path}/$imageName');
    if (!await imageFile.exists()) {
      await imageFile.create(recursive: true);
    }
    await image.saveTo(imageFile.path);

    return imageFile.path;
  }
}
