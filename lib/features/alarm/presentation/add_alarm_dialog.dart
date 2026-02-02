import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/alarm_provider.dart';

class AddAlarmDialog extends StatelessWidget {
  const AddAlarmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Alarm'),
      content: const Text('Pick time and date'),
      actions: [
        TextButton(
          onPressed: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (time == null) return;

            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );

            if (date == null) return;

            final dateTime = DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            );

            await context.read<AlarmProvider>().addAlarm(dateTime);
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
