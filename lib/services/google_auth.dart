import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> isGoogleAuthenticationDone() async {
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
    if (user == null) {
      return false;
    }

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

    return true;
  } catch (e) {
    print("Google Sign-In Error: $e");
    return false;
  }
}
