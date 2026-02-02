import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_gradients.dart';
import '../../../constants/app_text_styles.dart';
import '../../../providers/location_provider.dart';
import '../../alarm/presentation/alarm_screen.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  void _showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: const Text('Location permission denied'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LocationProvider>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.background,
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),

              Text(
                'Welcome! Your Smart\nTravel Alarm',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading,
              ),

              const SizedBox(height: 12),

              Text(
                'Stay on schedule and enjoy every moment of your journey.',
                textAlign: TextAlign.center,
                style: AppTextStyles.description,
              ),

              const SizedBox(height: 40),

              Image.asset(
                'assets/images/location.png',
                width: 305,
                height: 215,
              ),

              const Spacer(),

              // Use Current Location
              GestureDetector(
                onTap: () async {
                  await provider.requestLocation();
                  if (!provider.isAllowed) {
                    _showPermissionDeniedDialog(context);
                  }
                },
                child: Container(
                  width: 327,
                  height: 56,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(57),
                    border: Border.all(color: AppColors.white),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: AppColors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Use Current Location',
                        style: AppTextStyles.button,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Selected Location text
              if (provider.isAllowed)
                Text(
                  provider.locationText,
                  style: AppTextStyles.description,
                ),

              const SizedBox(height: 24),

              // Home → AlarmScreen
              GestureDetector(
                onTap: provider.isAllowed
                    ? () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AlarmScreen(
                        selectedLocation: provider.locationText,
                      ),
                    ),
                  );
                }
                    : null,
                child: Container(
                  width: 328,
                  height: 56,
                  margin: const EdgeInsets.only(bottom: 32),
                  decoration: BoxDecoration(
                    color: provider.isAllowed
                        ? AppColors.primary
                        : Colors.white24,
                    borderRadius: BorderRadius.circular(69),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Home',
                    style: AppTextStyles.button,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
