import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_gradients.dart';
import 'onboarding_page.dart';
import '../../../common_widgets/dot_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Discover the world, one journey at a time.',
      'desc':
      'From hidden gems to iconic destinations, we make travel simple and inspiring.',
    },
    {
      'title': 'Explore new horizons, one step at a time.',
      'desc':
      'Every trip holds a story waiting to be lived.',
    },
    {
      'title': 'See the beauty, one journey at a time.',
      'desc':
      'Travel made simple and exciting.',
    },
  ];

  void _onNext() {
    if (_currentIndex < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.background,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  itemBuilder: (context, index) {
                    return OnboardingPage(
                      title: _pages[index]['title']!,
                      description: _pages[index]['desc']!,
                    );
                  },
                ),
              ),

              DotIndicator(
                currentIndex: _currentIndex,
                count: _pages.length,
              ),

              const SizedBox(height: 24),

              GestureDetector(
                onTap: _onNext,
                child: Container(
                  width: 328,
                  height: 56,
                  margin: const EdgeInsets.only(bottom: 32),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(69),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
