import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _deviceIdentifier = "device_identifier";

  static Future<void> saveDeviceIdentifier(String deviceIdentifier) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_deviceIdentifier, deviceIdentifier);
  }

  static Future<String?> getDeviceIdentifier() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_deviceIdentifier);
  }

  static Future<void> clearDeviceIdentifier() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_deviceIdentifier);
  }
}
