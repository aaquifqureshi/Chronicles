/*
* File Name        : google_auth.dart
* Group            : trOlsz Group
* Description      : This file is has code for google Authentication.
*/

import 'package:chronicles/services/secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:chronicles/utilities/data/user_auth_data.dart';

Future<bool> isGoogleAuthenticationDone() async {
  SecureStorage storage = SecureStorage();
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return false;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = userCredential.user;

    String uid = userCredential.user!.uid;
    UserData data;
    DateTime nowTime = DateTime.now();

    if (user == null) {
      return false;
    }

    storage.updateSecureData('isLoginDone', 'true');
    storage.updateSecureData('isPinRequired', 'false');

    await FirebaseFirestore.instance.collection('user_account').doc(uid).set({
      'uid': uid,
      'username': user.displayName?.split(" ").first ?? "",
      'email': user.email ?? "",
      'firstname': user.displayName?.split(" ").first ?? "",
      'lastname': user.displayName?.split(" ").last ?? "",
      'gender': 3,
      'dob': '',
      'pfp_url': '',
      'join_date': nowTime.millisecondsSinceEpoch,
    }, SetOptions(merge: true));
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('user_account')
        .doc(uid)
        .get();

    data = UserData(
      uid: uid,
      email: userDoc['email'],
      username: userDoc['username'],
      firstName: userDoc['firstname'],
      lastName: userDoc['lastname'],
      joinDate: userDoc['join_date'],
    );

    String dataString = data.toJson();
    await storage.updateSecureData('UserData', dataString);
    return true;
  } catch (e) {
    return false;
  }
}
