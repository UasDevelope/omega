import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static const _storage = FlutterSecureStorage();
  static const String tokenKey = "auth_token";
  static const String fmcToken = "fmc_token";
  static const currentVideo = "current_video";
  // ✅ Save a String
  static Future<void> saveString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // ✅ Get a String
  static Future<String?> getString(String key) async {
    return await _storage.read(key: key);
  }

  // ✅ Save an int
  static Future<void> saveInt(String key, int value) async {
    await _storage.write(key: key, value: value.toString());
  }

  // ✅ Get an int
  static Future<int?> getInt(String key) async {
    String? value = await _storage.read(key: key);
    return value != null ? int.tryParse(value) : null;
  }

  // ✅ Save a double
  static Future<void> saveDouble(String key, double value) async {
    await _storage.write(key: key, value: value.toString());
  }

  // ✅   Get a double
  static Future<double?> getDouble(String key) async {
    String? value = await _storage.read(key: key);
    return value != null ? double.tryParse(value) : null;
  }

  // ✅ Save a boolean
  static Future<void> saveBool(String key, bool value) async {
    await _storage.write(key: key, value: value.toString());
  }

  // ✅ Get a boolean
  static Future<bool?> getBool(String key) async {
    String? value = await _storage.read(key: key);
    return value == "true" ? true : false;
  }

  // ✅ Save a List<String>
  static Future<void> saveList(String key, List<String> list) async {
    String jsonString = jsonEncode(list);
    await _storage.write(key: key, value: jsonString);
  }

  // ✅ Get a List<String>
  static Future<List<String>?> getList(String key) async {
    String? jsonString = await _storage.read(key: key);
    return jsonString != null
        ? List<String>.from(jsonDecode(jsonString))
        : null;
  }

// ✅ Modify deleteValue() to return bool
  static Future<bool> deleteValue(String key) async {
    try {
      await _storage.delete(key: key);
      return true; // ✅ Indicate success
    } catch (e) {
      log("Error deleting value: $e");
      return false; // ✅ Indicate failure
    }
  }

  // ✅ Check if key exists
  static Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }

  // ✅ Clear all stored values
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
