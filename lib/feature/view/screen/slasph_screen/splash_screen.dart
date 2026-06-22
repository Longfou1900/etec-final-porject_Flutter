import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/core/auth/auth_theme.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const _navigationDelay = Duration(milliseconds: 2800);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AuthTheme.headerGradient),
        child: Stack(
          children: const [
            _BackgroundCircles(),
            _SplashContent(),
          ],
        ),
      ),
    );
  }
}

class _BackgroundCircles extends StatelessWidget {
  const _BackgroundCircles();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned(
          top: -80,
          right: -60,
          child: _Circle(size: 260, opacity: 0.08),
        ),
        Positioned(
          top: 80,
          right: -100,
          child: _Circle(size: 200, opacity: 0.05),
        ),
        Positioned(
          bottom: -100,
          left: -60,
          child: _Circle(size: 300, opacity: 0.08),
        ),
        Positioned(
          bottom: 80,
          left: -80,
          child: _Circle(size: 180, opacity: 0.05),
        ),
      ],
    );
  }
}

class _Circle extends StatelessWidget {
  final double size;
  final double opacity;

  const _Circle({
    required this.size,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: opacity),
      ),
    );
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: SplashScreen._navigationDelay,
        curve: Curves.easeOut,
        onEnd: _goToOnboarding,
        builder: (context, value, child) {
          final visibleProgress = (value / 0.55).clamp(0.0, 1.0);
          final textProgress = ((value - 0.25) / 0.4).clamp(0.0, 1.0);

          return Opacity(
            opacity: visibleProgress,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SplashLogo(scale: 0.6 + (visibleProgress * 0.4)),
                const SizedBox(height: 28),
                _SplashText(offsetY: 30 * (1 - textProgress)),
                const SizedBox(height: 80),
                const _LoadingIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }

  void _goToOnboarding() {
    if (Get.currentRoute == '/splash') {
      Get.offAllNamed('/onboarding');
    }
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
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: const Icon(
          Icons.watch_rounded,
          color: Colors.white,
          size: 52,
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
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your premium watch companion',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
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
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 22,
      height: 22,
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2.4,
      ),
    );
  }
}
