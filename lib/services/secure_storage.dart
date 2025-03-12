/*
* File Name        : search_in_device.dart
* Group            : trOlsz Group
* Description      : This file is has code for Storing critical data in
*                    Androids Keystone, and iOS Keychain.
*/

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  void writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String> readSecureData(String key) async {
    String value = await storage.read(key: key) ?? 'null';
    return value;
  }

  void deleteSecureData(String key) async {
    await storage.delete(key: key);
  }

  Future<void> updateSecureData(String key, String newValue) async {
    deleteSecureData(key);
    writeSecureData(key, newValue);
  }
}
