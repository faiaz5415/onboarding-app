import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../constants/app_colors.dart';

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
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),

        // Video
        Container(
          width: 360,
          height: 429,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
          ),
          clipBehavior: Clip.hardEdge,
          child: _controller.value.isInitialized
              ? VideoPlayer(_controller)
              : const Center(
            child: CircularProgressIndicator(
              color: AppColors.white,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        const Spacer(),
      ],
    );
  }
}
