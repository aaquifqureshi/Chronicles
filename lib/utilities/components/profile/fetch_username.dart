import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chronicles/services/secure_storage.dart';
import '../../../services/internet_connectivity.dart';

class UserService {
  static Future<String> getUsername() async {
    SecureStorage storage = SecureStorage();
    String userId = await storage.readSecureData('user_id') ?? '';

    if (userId.isEmpty) {
      return 'Unknown';
    }

    bool hasInternet = await getInternetStatus();
    if (!hasInternet) {
      return await getStoredUsername(userId);
    }

    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user_account')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        String username = userDoc['username'] ?? 'Unknown';
        await saveUsername(userId, username);
        return username;
      }
    } catch (e) {
      print("Error fetching username: $e");
    }
    return await getStoredUsername(userId);
  }

  static Future<void> saveUsername(String userId, String username) async {
    SecureStorage storage = SecureStorage();
    storage.writeSecureData('username_$userId', username);
  }

  static Future<String> getStoredUsername(String userId) async {
    SecureStorage storage = SecureStorage();
    return await storage.readSecureData('username_$userId') ?? 'Unknown';
  }
}