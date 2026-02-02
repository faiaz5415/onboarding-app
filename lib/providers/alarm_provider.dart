import 'package:flutter/material.dart';
import '../helpers/notification_helper.dart';
import '../helpers/storage_helper.dart';

class AlarmProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _alarms = [];

  List<Map<String, dynamic>> get alarms => _alarms;

  AlarmProvider() {
    loadAlarms();
  }

  Future<void> loadAlarms() async {
    _alarms = await StorageHelper.load();
    notifyListeners();
  }

  Future<void> addAlarm(DateTime dateTime) async {
    final int alarmId = DateTime.now().millisecondsSinceEpoch;

    final alarm = {
      'id': alarmId,
      'time': dateTime.toIso8601String(),
      'enabled': true,
    };

    _alarms.add(alarm);

    await NotificationHelper.schedule(
      id: alarmId,
      dateTime: dateTime,
    );

    await StorageHelper.save(_alarms);
    notifyListeners();
  }

  Future<void> toggleAlarm(int index) async {
    _alarms[index]['enabled'] = !_alarms[index]['enabled'];

    final int alarmId = _alarms[index]['id'] as int;
    final DateTime alarmTime =
    DateTime.parse(_alarms[index]['time'] as String);

    if (_alarms[index]['enabled']) {
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
