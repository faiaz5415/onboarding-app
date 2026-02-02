import 'package:flutter/material.dart';
import '../helpers/notification_helper.dart';
import '../helpers/storage_helper.dart';

class AlarmProvider extends ChangeNotifier {
  List<Map<String, dynamic>> alarms = [];

  AlarmProvider() {
    loadAlarms();
  }

  Future<void> loadAlarms() async {
    alarms = await StorageHelper.load();
    notifyListeners();
  }

  Future<void> addAlarm(DateTime dateTime) async {
    final int alarmId = DateTime.now().millisecondsSinceEpoch;

    final alarm = {
      'id': alarmId,
      'time': dateTime.toIso8601String(),
      'enabled': true,
    };

    alarms.add(alarm);

    await NotificationHelper.schedule(
      id: alarmId,
      dateTime: dateTime,
    );

    await StorageHelper.save(alarms);
    notifyListeners();
  }

  Future<void> toggleAlarm(int index) async {
    alarms[index]['enabled'] = !alarms[index]['enabled'];

    final int alarmId = alarms[index]['id'] as int;
    final DateTime time =
    DateTime.parse(alarms[index]['time'] as String);

    if (alarms[index]['enabled']) {
      await NotificationHelper.schedule(
        id: alarmId,
        dateTime: time,
      );
    } else {
      await NotificationHelper.cancel(alarmId);
    }

    await StorageHelper.save(alarms);
    notifyListeners();
  }
}
