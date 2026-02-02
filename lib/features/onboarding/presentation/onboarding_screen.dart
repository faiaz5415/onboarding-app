import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_gradients.dart';
import '../../../constants/app_text_styles.dart';
import '../../../common_widgets/dot_indicator.dart';
import '../../../providers/onboarding_provider.dart';
import 'onboarding_page.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController _pageController = PageController();

  final List<Map<String, String>> _pages = [
    {
      'title': 'Discover the world, one journey at a time.',
      'desc':
      'From hidden gems to iconic destinations, we make travel simple and inspiring.',
      'video': 'assets/videos/onboarding_1.mp4',
    },
    {
      'title': 'Explore new horizons, one step at a time.',
      'desc': 'Every trip holds a story waiting to be lived.',
      'video': 'assets/videos/onboarding_2.mp4',
    },
    {
      'title': 'See the beauty, one journey at a time.',
      'desc': 'Travel made simple and exciting.',
      'video': 'assets/videos/onboarding_3.mp4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final onboardingProvider = context.watch<OnboardingProvider>();

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
                  child: Text(
                    'Skip',
                    style: AppTextStyles.skip,
                  ),
                ),
              ),

              // PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: onboardingProvider.setPage,
                  itemBuilder: (context, index) {
                    return OnboardingPage(
                      title: _pages[index]['title']!,
                      description: _pages[index]['desc']!,
                      videoPath: _pages[index]['video']!,
                    );
                  },
                ),
              ),

              // Dots
              DotIndicator(
                currentIndex: onboardingProvider.currentIndex,
                count: _pages.length,
              ),

              const SizedBox(height: 24),

              // Next button
              GestureDetector(
                onTap: () => onboardingProvider.nextPage(
                  _pages.length,
                  _pageController,
                  context,
                ),
                child: Container(
                  width: 328,
                  height: 56,
                  margin: const EdgeInsets.only(bottom: 32),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(69),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Next',
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
