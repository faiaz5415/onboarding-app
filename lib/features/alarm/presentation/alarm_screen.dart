import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_gradients.dart';
import '../../../providers/alarm_provider.dart';
import 'add_alarm_dialog.dart';

class AlarmScreen extends StatelessWidget {
  final String selectedLocation;

  const AlarmScreen({
    super.key,
    required this.selectedLocation,
  });

  @override
  Widget build(BuildContext context) {
    final alarmProvider = context.watch<AlarmProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.background,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),

                const Text(
                  'Selected Location',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.white70, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        selectedLocation.isEmpty
                            ? 'Add your location'
                            : selectedLocation,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Alarms',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 16),

                Expanded(
                  child: alarmProvider.alarms.isEmpty
                      ? const Center(
                    child: Text(
                      'No alarms yet',
                      style: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  )
                      : ListView.separated(
                    itemCount: alarmProvider.alarms.length,
                    separatorBuilder: (_, __) =>
                    const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final alarm = alarmProvider.alarms[index];
                      final dateTime =
                      DateTime.parse(alarm['time']);

                      final timeText =
                      TimeOfDay.fromDateTime(dateTime)
                          .format(context);

                      final dateText =
                          '${_weekday(dateTime.weekday)} '
                          '${dateTime.day} '
                          '${_month(dateTime.month)} '
                          '${dateTime.year}';

                      return Container(
                        height: 56,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Row(
                          children: [
                            Text(
                              timeText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const Spacer(),
                            Text(
                              dateText,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Switch(
                              value: alarm['enabled'],
                              activeColor: AppColors.primary,
                              onChanged: (_) {
                                context
                                    .read<AlarmProvider>()
                                    .toggleAlarm(index);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () async {

          final selectedDateTime = await showDialog<DateTime>(
            context: context,
            builder: (_) => const AddAlarmDialog(),
          );

          if (selectedDateTime != null) {
            context.read<AlarmProvider>().addAlarm(selectedDateTime);
          }
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  String _weekday(int day) =>
      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][day - 1];

  String _month(int month) =>
      ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][month - 1];
}
