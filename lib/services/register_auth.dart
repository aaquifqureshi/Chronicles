import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

Future<String> registerAuthentication(BuildContext context, String firstName,
    String lastName, String email, String password) async {
  if (email.isEmpty ||
      password.isEmpty ||
      firstName.isEmpty ||
      lastName.isEmpty) {
    return 'emptyFields';
  }

  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String userId = userCredential.user!.uid;
    print(userId);

    try {
      await FirebaseFirestore.instance
          .collection('user_account')
          .doc(userId)
          .set({
        'user_id': userId,
        'username': '',
        'user_email': email,
        'user_firstname': firstName,
        'user_lastname': lastName,
        'user_gender': '',
        'user_dob': '',
        'user_pfp_url': '',
        'join_date': Timestamp.now(),
        'theme_id': '',
      });

      print("User document successfully created!");
    } catch (e) {
      print("Firestore Error: $e");
    }

    return 'true';
  } on FirebaseAuthException catch (e) {
    //print(e.message);
    if (e.code == 'email-already-in-use') {
      return 'emailAlreadyUsed';
    } else if (e.code == 'invalid-email') {
      return "invalidEmail";
      // }else if(e.message != null && e.message!.contains("PASSWORD_DOES_NOT_MEET_REQUIREMENTS")){
      //   return 'invalidPasswordFormat';
    }
    return 'unexpectedError';
  }
}
