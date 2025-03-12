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

    if (user == null) {
      return false;
    }

    storage.updateSecureData('isLoginDone', 'true');
    storage.updateSecureData('isPinRequired', 'false');

    await FirebaseFirestore.instance
        .collection('user_account')
        .doc(user.uid)
        .set({
      'user_id': user.uid,
      'username': user.displayName?.split(" ").first ?? "",
      'user_email': user.email ?? "",
      'user_firstname': user.displayName?.split(" ").first ?? "",
      'user_lastname': user.displayName?.split(" ").last ?? "",
      'user_gender': '',
      'user_dob': '',
      'user_pfp_url': '',
      'join_date': Timestamp.now(),
      'theme_id': '',
    }, SetOptions(merge: true));

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    data = UserData(
      uid: uid,
      email: userDoc['firstName'],
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
