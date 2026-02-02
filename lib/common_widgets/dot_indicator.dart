import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class DotIndicator extends StatelessWidget {
  final int currentIndex;
  final int count;

  const DotIndicator({
    super.key,
    required this.currentIndex,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.white24,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
