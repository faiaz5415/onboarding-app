import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/alarm_provider.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';
import 'add_alarm_dialog.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AlarmProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarms'),
        backgroundColor: AppColors.primary,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const AddAlarmDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: provider.alarms.isEmpty
          ? const SizedBox()
          : ListView.builder(
        itemCount: provider.alarms.length,
        itemBuilder: (context, index) {
          final alarm = provider.alarms[index];
          final time = DateTime.parse(alarm['time']);

          return ListTile(
            title: Text(
              '${time.hour}:${time.minute.toString().padLeft(2, '0')}',
              style: AppTextStyles.heading,
            ),
            subtitle: Text(
              '${time.day}/${time.month}/${time.year}',
              style: AppTextStyles.description,
            ),
            trailing: Switch(
              value: alarm['enabled'],
              onChanged: (_) =>
                  context.read<AlarmProvider>().toggleAlarm(index),
            ),
          );
        },
      ),
    );
  }
}
