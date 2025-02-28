import 'package:chronicles/services/secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> isGoogleAuthenticationDone() async {
  SecureStorage storage = SecureStorage();
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      await storage.updateSecureData('isGoogleAuthDone', 'false');
      return false;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = userCredential.user;
    if (user == null) {
      await storage.updateSecureData('isGoogleAuthDone', 'false');
      return false;
    }

    String userId = userCredential.user!.uid;
    await storage.updateSecureData('user_id', userId);
    storage.updateSecureData('isLoginDone', 'true');
    storage.updateSecureData('isPinRequired', 'false');

    await FirebaseFirestore.instance.collection('user_account').doc(user.uid).set({
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
    await storage.updateSecureData('isGoogleAuthDone', 'false');
    return false;
  }
}