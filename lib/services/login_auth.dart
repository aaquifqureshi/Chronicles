import 'package:firebase_auth/firebase_auth.dart';
import 'package:chronicles/services/secure_storage.dart';

Future<bool> isLoginDone() async {
  SecureStorage loginAuth = SecureStorage();

  String value = await loginAuth.readSecureData('isLoginDone');
  if (value != 'null') {
    if (value == 'true') {
      return true;
    } else {
      return false;
    }
  }
  loginAuth.writeSecureData('isLoginDone', 'false');
  return false;
}

Future<String> loginAuthentication(
    context, String email, String password) async {
  if (email.isEmpty || password.isEmpty) {
    return 'emptyFields';
  }
  SecureStorage storage = SecureStorage();

  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    storage.updateSecureData('isLoginDone', 'true');
    return 'true';
  } on FirebaseAuthException catch (e) {
    if (e.code == 'invalid-credential') {
      storage.updateSecureData('isLoginDone', 'false');
      return "invalidCredentials";
    }
    storage.updateSecureData('isLoginDone', 'false');
    return "unexpectedError";
  }
}
