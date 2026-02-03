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
      'From hidden gems to iconic destinations, we make travel simple, inspiring, and unforgettable. Start your next adventure today.',
      'video': 'assets/videos/onboarding_1.mp4',
    },
    {
      'title': 'Explore new horizons, one step at a time.',
      'desc':
      'Every trip holds a story waiting to be lived. Let us guide you to experiences that inspire, connect, and last a lifetime.',
      'video': 'assets/videos/onboarding_2.mp4',
    },
    {
      'title': 'See the beauty, one journey at a time.',
      'desc':
      'Travel made simple and exciting—discover places you’ll love and moments you’ll never forget.',
      'video': 'assets/videos/onboarding_3.mp4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.background,
        ),
        child: SafeArea(
          top: false,
          bottom: true,
          child: Column(
            children: [

              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: provider.setPage,
                  itemBuilder: (_, index) {
                    return OnboardingPage(
                      title: _pages[index]['title']!,
                      description: _pages[index]['desc']!,
                      videoPath: _pages[index]['video']!,
                    );
                  },
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: DotIndicator(
                  currentIndex: provider.currentIndex,
                  count: _pages.length,
                ),
              ),

              const SizedBox(height: 24),


              GestureDetector(
                onTap: () => provider.nextPage(
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
