/*
* File Name        : user_auth_data.dart
* Group            : trOlsz Group
* Description      : This file contains code for User Data Class
*                     and UserDataFetcher Class.
*/

import 'dart:convert';

import 'package:chronicles/services/secure_storage.dart';
import 'package:chronicles/utilities/data/gender.dart';

class UserData {
  late String uid;
  late String? username;
  late String email;
  late String? firstName;
  late String? lastName;
  late Gender gender;
  late int themeId;
  late int streak;
  late int maxStreak;
  late int joinDate;

  UserData({
    required this.uid,
    required this.email,
    required this.joinDate,
    this.username,
    this.firstName,
    this.lastName,
    this.gender = Gender.preferNotToSay,
    this.themeId = 7,
    this.streak = 0,
    this.maxStreak = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender.index,
      'themeId': themeId,
      'streak': streak,
      'maxStreak': maxStreak,
      'join_date': joinDate,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    Gender gender = (map['gender'] == 0)
        ? Gender.male
        : (map['gender'] == 1)
            ? Gender.female
            : (map['gender'] == 2)
                ? Gender.other
                : Gender.preferNotToSay;

    return UserData(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      username: map['username'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      gender: gender,
      themeId: map['themeId'] ?? 7,
      streak: map['streak'] ?? 0,
      maxStreak: map['maxStreak'] ?? 0,
      joinDate: map['join_date'],
    );
  }

  String toJson() {
    final map = toMap();
    return json.encode(map);
  }

  factory UserData.fromJson(String source) {
    final map = json.decode(source);
    return UserData.fromMap(map);
  }
}

class UserDataFetcher {
  SecureStorage storage = SecureStorage();

  Future<UserData> fetchUserData() async {
    String stringData = await storage.readSecureData('UserData');
    UserData data = UserData.fromJson(stringData);
    return data;
  }

  Future<String> fetchUID() async {
    UserData data = await fetchUserData();
    return data.uid;
  }

  Future<String> fetchEmail() async {
    UserData data = await fetchUserData();
    return data.email;
  }

  Future<String> fetchUsername() async {
    UserData data = await fetchUserData();

    return data.username ?? 'DarthJarJar';
  }

  Future<String> fetchFirstName() async {
    UserData data = await fetchUserData();

    return data.firstName ?? 'JarJar';
  }

  Future<String> fetchLastName() async {
    UserData data = await fetchUserData();

    return data.lastName ?? 'Binks';
  }

  Future<Gender> fetchGender() async {
    UserData data = await fetchUserData();

    return data.gender;
  }

  Future<int> fetchThemeID() async {
    UserData data = await fetchUserData();

    return data.themeId;
  }

  Future<int> fetchStreak() async {
    UserData data = await fetchUserData();

    return data.streak;
  }

  Future<int> fetchMaxStreak() async {
    UserData data = await fetchUserData();

    return data.maxStreak;
  }

  Future<DateTime> fetchJoinDate() async {
    UserData data = await fetchUserData();

    return DateTime.fromMillisecondsSinceEpoch(data.joinDate);
  }
}
