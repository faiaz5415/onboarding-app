import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../constants/app_text_styles.dart';

class OnboardingPage extends StatefulWidget {
  final String title;
  final String description;
  final String videoPath;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.videoPath,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        _controller
          ..setLooping(true)
          ..setVolume(1.0) // 🔊 sound ON (as per requirement)
          ..play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isFirst =>
      widget.title.startsWith('Discover the world');

  bool get _isThird =>
      widget.title.startsWith('See the beauty');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔹 VIDEO + SKIP OVERLAY
        Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              child: SizedBox(
                height: 430,
                width: double.infinity,
                child: Stack(
                  children: [
                    // Video
                    Positioned.fill(
                      child: _controller.value.isInitialized
                          ? FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _controller.value.size.width,
                          height: _controller.value.size.height,
                          child: VideoPlayer(_controller),
                        ),
                      )
                          : const SizedBox(),
                    ),

                    // Bottom gradient (≈40–45%)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: 190,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Color(0xFF0B0024),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 🔹 SKIP (overlay on video)
            Positioned(
              top: 44,
              right: 16,
              child: Text(
                'Skip',
                style: AppTextStyles.button,
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),


        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              Text(
                widget.title,
                style: _isFirst
                    ? AppTextStyles.onboardingHeadingShadow
                    : _isThird
                    ? AppTextStyles.onboardingHeadingSmall
                    : AppTextStyles.onboardingHeading,
              ),

              const SizedBox(height: 12),


              Text(
                widget.description,
                style: _isFirst
                    ? AppTextStyles.onboardingDescription
                    : AppTextStyles.onboardingDescriptionCompact,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
