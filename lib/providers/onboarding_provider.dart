import 'package:flutter/material.dart';
import '../features/location/presentation/location_screen.dart';


class OnboardingProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setPage(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void nextPage(
      int totalPages,
      PageController controller,
      BuildContext context,
      ) {
    if (_currentIndex < totalPages - 1) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LocationScreen(),
        ),
      );
    }
  }
}
