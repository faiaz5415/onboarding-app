import 'package:flutter/material.dart';

class AppTextStyles {
  // 🔹 ONBOARDING HEADING (default – onboarding 1 & 2)
  static const TextStyle onboardingHeading = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 24, // Display/xs equivalent
    height: 34 / 24, // exact line-height
    color: Colors.white,
    letterSpacing: 0,
  );

  // 🔹 ONBOARDING HEADING WITH SHADOW (only onboarding 1)
  static const TextStyle onboardingHeadingShadow = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 34 / 24,
    color: Colors.white,
    letterSpacing: 0,
    shadows: [
      Shadow(
        offset: Offset(0, 4),
        blurRadius: 4,
        color: Color(0x40000000),
      ),
    ],
  );

  // 🔹 ONBOARDING HEADING SMALL (onboarding 3)
  static const TextStyle onboardingHeadingSmall = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 22, // Display/xxs equivalent
    height: 36 / 22,
    color: Colors.white,
    letterSpacing: 0,
  );

  // 🔹 DESCRIPTION (default – onboarding 1)
  static const TextStyle onboardingDescription = TextStyle(
    fontFamily: 'Oxygen',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.48, // 148%
    color: Colors.white,
    letterSpacing: 0,
  );

  // 🔹 DESCRIPTION COMPACT (onboarding 2 & 3)
  static const TextStyle onboardingDescriptionCompact = TextStyle(
    fontFamily: 'Oxygen',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.0,
    color: Colors.white,
    letterSpacing: 0,
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.0,
    color: Colors.white,
  );

}
