import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chronicles/services/secure_storage.dart';
import 'package:flutter/cupertino.dart';

Future<String> registerAuthentication(BuildContext context, String firstName,
    String lastName, String email, String password) async {
  if (email.isEmpty ||
      password.isEmpty ||
      firstName.isEmpty ||
      lastName.isEmpty) {
    return 'emptyFields';
  }

  SecureStorage storage = SecureStorage();

  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String userId = userCredential.user!.uid;

    try {
      await FirebaseFirestore.instance
          .collection('user_account')
          .doc(userId)
          .set({
        'user_id': userId,
        'username': firstName,
        'user_email': email,
        'user_firstname': firstName,
        'user_lastname': lastName,
        'user_gender': '',
        'user_dob': '',
        'user_pfp_url': '',
        'join_date': Timestamp.now(),
        'theme_id': '',
      });
    } catch (e) {
      print("Firestore Error: $e");
    }

    await storage.updateSecureData('user_id', userId);
    storage.updateSecureData('isLoginDone', 'true');
    storage.updateSecureData('isPinRequired', 'false');
    return 'true';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      storage.updateSecureData('isLoginDone', 'false');
      storage.updateSecureData('isPinRequired', 'false');
      return 'emailAlreadyUsed';
    }else if(e.code == 'invalid-email'){
      storage.updateSecureData('isLoginDone', 'false');
      return "invalidEmailSyntax";
    }
    // }else if(e.message != null && e.message!.contains("PASSWORD_DOES_NOT_MEET_REQUIREMENTS")){
    //   return 'invalidPasswordFormat';
  }
  storage.updateSecureData('isLoginDone', 'false');
  storage.updateSecureData('isPinRequired', 'false');
  return 'unexpectedError';
}
