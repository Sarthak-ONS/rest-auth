import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SaveDataApi {
// Create storage
  static const storage = FlutterSecureStorage();

  Future saveTokenToStorage({String? idToken, String? refreshToken}) async {
    try {
      await storage.write(key: "idToken", value: idToken);
      await storage.write(key: "refreshToken", value: refreshToken);
    } catch (e) {
      print("Error while saving tokens");
      print(e.toString());
    }
  }

// // Read value
// String value = await storage.read(key: key);

// // Read all values
// Map<String, String> allValues = await storage.readAll();

// // Delete value
// await storage.delete(key: key);

// // Delete all
// await storage.deleteAll();

// // Write value
// await storage.write(key: key, value: value);

}
