import 'package:flutter/material.dart';
import '../helpers/notification_helper.dart';
import '../helpers/storage_helper.dart';

class AlarmProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _alarms = [];

  List<Map<String, dynamic>> get alarms => _alarms;

  AlarmProvider() {
    _init();
  }

  // 🔹 Async init wrapper (safer than calling async directly in constructor)
  Future<void> _init() async {
    await loadAlarms();
  }

  Future<void> loadAlarms() async {
    final loadedAlarms = await StorageHelper.load();
    _alarms = List<Map<String, dynamic>>.from(loadedAlarms);
    notifyListeners();
  }

  Future<void> addAlarm(DateTime dateTime) async {
    final int alarmId =
    DateTime.now().millisecondsSinceEpoch & 0x7FFFFFFF;

    final alarm = {
      'id': alarmId,
      'time': dateTime.toIso8601String(),
      'enabled': true,
    };

    // ✅ Always create a NEW list reference
    _alarms = [..._alarms, alarm];

    await NotificationHelper.schedule(
      id: alarmId,
      dateTime: dateTime,
    );

    await StorageHelper.save(_alarms);
    notifyListeners();
  }

  Future<void> toggleAlarm(int index) async {
    final updatedAlarms =
    List<Map<String, dynamic>>.from(_alarms);

    final current = updatedAlarms[index];
    final bool newState = !(current['enabled'] as bool);

    updatedAlarms[index] = {
      ...current,
      'enabled': newState,
    };

    _alarms = updatedAlarms;

    final int alarmId = current['id'] as int;
    final DateTime alarmTime =
    DateTime.parse(current['time'] as String);

    if (newState) {
      await NotificationHelper.schedule(
        id: alarmId,
        dateTime: alarmTime,
      );
    } else {
      await NotificationHelper.cancel(alarmId);
    }

    await StorageHelper.save(_alarms);
    notifyListeners();
  }
}
