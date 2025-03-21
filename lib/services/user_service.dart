import 'package:chronicles/services/secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utilities/data/user_auth_data.dart';

Future<int> getNextUserIndex() async {
  DocumentReference counterRef =
      FirebaseFirestore.instance.collection('total_users').doc('user_count');
  return FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot doc = await transaction.get(counterRef);

    int lastIndex = doc.exists ? (doc['last_index'] as int) : 0;
    int newIndex = lastIndex + 1;

    transaction.set(
        counterRef, {'last_index': newIndex}, SetOptions(merge: true));

    return newIndex;
  });
}

void updateUserIndex(int newIndex) async {
  DocumentReference counterRef =
      FirebaseFirestore.instance.collection('total_users').doc('user_count');

  await counterRef.set({'last_index': newIndex}, SetOptions(merge: true));
}

Future<String> updateUsername(BuildContext context, String username) async {
  SecureStorage storage = SecureStorage();
  FirebaseAuth auth = FirebaseAuth.instance;
  String? uid = auth.currentUser?.uid;
  UserData data;

  if (uid == null) return "userNotLoggedIn";
  if (username.isEmpty) return "emptyField";

  var querySnapshot = await FirebaseFirestore.instance
      .collection('user_account')
      .where('username', isEqualTo: username)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return "usernameTaken";
  }

  RegExp invaliedUsername = RegExp(r'^user\d*$', caseSensitive: false);
  if (invaliedUsername.hasMatch(username)) {
    return "invalidUsername";
  }

  if (username.length < 4 || username.length > 8 || username.contains(' ')) {
    return "invalidLength";
  }

  await FirebaseFirestore.instance.collection('user_account').doc(uid).update({
    'username': username,
  });
  DocumentSnapshot userDoc = await FirebaseFirestore.instance
      .collection('user_account')
      .doc(uid)
      .get();

  data = UserData(
    uid: uid,
    email: userDoc['email'],
    username: username,
    firstName: userDoc['firstname'],
    lastName: userDoc['lastname'],
    joinDate: userDoc['join_date'],
  );
  String dataString = data.toJson();

  await storage.updateSecureData('UserData', dataString);
  storage.updateSecureData('isLoginDone', 'true');
  storage.updateSecureData('isPinRequired', 'false');

  return "success";
}
