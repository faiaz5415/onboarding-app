import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/alarm_provider.dart';
import '../../../constants/app_text_styles.dart';
import '../../../constants/app_colors.dart';

class AddAlarmDialog extends StatefulWidget {
  const AddAlarmDialog({super.key});

  @override
  State<AddAlarmDialog> createState() => _AddAlarmDialogState();
}

class _AddAlarmDialogState extends State<AddAlarmDialog> {
  DateTime? _selectedDateTime;

  Future<void> _pickTimeAndDate(BuildContext context) async {
    // 1️⃣ Time Picker
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    // 2️⃣ Date Picker
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    setState(() {
      _selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text('Add Alarm'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Select Time & Date
          GestureDetector(
            onTap: () => _pickTimeAndDate(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: Text(
                _selectedDateTime == null
                    ? 'Select Time & Date'
                    : '${_selectedDateTime!.hour.toString().padLeft(2, '0')}:'
                    '${_selectedDateTime!.minute.toString().padLeft(2, '0')} · '
                    '${_selectedDateTime!.day}/'
                    '${_selectedDateTime!.month}/'
                    '${_selectedDateTime!.year}',
                style: AppTextStyles.description,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Save Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _selectedDateTime == null
                  ? null
                  : () async {
                await context
                    .read<AlarmProvider>()
                    .addAlarm(_selectedDateTime!);

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
