import 'package:chronicles/services/secure_storage.dart';

Future<bool> isPinRequired() async {
  SecureStorage loginAuth = SecureStorage();

  String value = await loginAuth.readSecureData('isPinRequired');
  if (value != 'null') {
    if (value == 'true') {
      return true;
    } else {
      return false;
    }
  }
  loginAuth.writeSecureData('isPinRequired', 'false');
  return false;
}
