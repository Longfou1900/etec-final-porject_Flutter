import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/core/auth/auth_theme.dart';
import 'package:flutter_projects_getx/core/theme/app_colors.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const _navigationDelay = Duration(milliseconds: 2800);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: SplashScreen._navigationDelay,
    );

    _progress = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _goToOnboarding();
      }
    });

    _controller.forward();
  }

  void _goToOnboarding() {
    if (Get.currentRoute == '/splash') {
      Get.offAllNamed('/onboarding');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFEEF1FF),
              Color(0xFFE3E7FF),
              Color(0xFFF7F8FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            _BackgroundCircles(),
            _SplashContent(progress: _progress),
          ],
        ),
      ),
    );
  }
}

class _BackgroundCircles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -120,
          right: -70,
          child: _Circle(size: 320, opacity: 0.10),
        ),
        Positioned(
          top: 70,
          right: -120,
          child: _Circle(size: 240, opacity: 0.06),
        ),
        Positioned(
          bottom: -140,
          left: -100,
          child: _Circle(size: 360, opacity: 0.10),
        ),
        Positioned(
          bottom: 90,
          left: -120,
          child: _Circle(size: 220, opacity: 0.06),
        ),
      ],
    );
  }
}

class _Circle extends StatelessWidget {
  final double size;
  final double opacity;

  const _Circle({required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AuthTheme.primaryDark.withOpacity(opacity),
      ),
    );
  }
}

class _SplashContent extends StatelessWidget {
  final Animation<double> progress;

  const _SplashContent({required this.progress});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, _) {
        final value = progress.value;
        final visibleProgress = (value / 0.55).clamp(0.0, 1.0);
        final textProgress = ((value - 0.25) / 0.4).clamp(0.0, 1.0);

        return Opacity(
          opacity: visibleProgress,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SplashLogo(scale: 0.65 + (visibleProgress * 0.35)),
                const SizedBox(height: 22),
                _SplashText(offsetY: 26 * (1 - textProgress)),
                const SizedBox(height: 70),
                _LoadingIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SplashLogo extends StatelessWidget {
  final double scale;

  const _SplashLogo({required this.scale});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Container(
        width: 104,
        height: 104,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.65),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.white.withOpacity(0.85),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.18),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: const Icon(
          Icons.watch_rounded,
          color: AppColors.primary,
          size: 54,
        ),
      ),
    );
  }
}

class _SplashText extends StatelessWidget {
  final double offsetY;

  const _SplashText({required this.offsetY});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, offsetY),
      child: Column(
        children: [
          const Text(
            'Argumind',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 36,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your premium watch companion',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 26,
      height: 26,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        strokeWidth: 2.6,
      ),
    );
  }
}

