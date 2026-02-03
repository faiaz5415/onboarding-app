import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_gradients.dart';
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
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppGradients.background,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 40),

                /// Heading (Figma exact)
                SizedBox(
                  width: 326,
                  child: Text(
                    'Welcome! Your Smart\nTravel Alarm',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600, // SemiBold
                      fontSize: 24,
                      height: 34 / 24,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                /// Description (Figma exact)
                SizedBox(
                  width: 326,
                  child: Text(
                    'Stay on schedule and enjoy every moment of your journey.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 24 / 16,
                      color: Color(0xFFE0E0E0),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                /// Image (Figma size & position)
                Image.asset(
                  'assets/images/location.png',
                  width: 305,
                  height: 215,
                  fit: BoxFit.contain,
                ),

                const Spacer(),

                /// Use Current Location
                GestureDetector(
                  onTap: () async {
                    await provider.requestLocation();
                    if (!provider.isAllowed) {
                      _showPermissionDeniedDialog(context);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(57),
                      border: Border.all(color: AppColors.white),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Use Current Location',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.location_on, color: Colors.white),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                if (provider.isAllowed)
                  Text(
                    provider.locationText,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),

                const SizedBox(height: 24),

                /// Home Button
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
                    width: double.infinity,
                    height: 56,
                    margin: const EdgeInsets.only(bottom: 32),
                    decoration: BoxDecoration(
                      color: provider.isAllowed
                          ? AppColors.primary
                          : Colors.white24,
                      borderRadius: BorderRadius.circular(69),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Home',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
