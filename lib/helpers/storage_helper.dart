import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static const _key = 'alarms';

  static Future<void> save(List<Map<String, dynamic>> alarms) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_key, jsonEncode(alarms));
  }

  static Future<List<Map<String, dynamic>>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(data));
  }
}
