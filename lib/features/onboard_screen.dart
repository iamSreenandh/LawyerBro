import 'package:flutter/material.dart';
import 'package:lawyer_bro/styles/app_colors.dart';
import 'package:lawyer_bro/styles/app_text_styles.dart';
import 'package:lawyer_bro/utils/local_storage.dart';

// ─────────────────────────────────────────────────────────────────────────────
// OnBoardScreen
// Splash → 3 onboarding slides → done callback
// ─────────────────────────────────────────────────────────────────────────────
class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen>
    with SingleTickerProviderStateMixin {
  // ── state ──────────────────────────────────────────────────────────────────
  bool _showSplash = true;
  int _currentPage = 0;
  final PageController _pageController = PageController();

  // ── splash animation ───────────────────────────────────────────────────────
  late final AnimationController _splashAnimController;
  late final Animation<double> _splashFade;
  late final Animation<double> _splashScale;

  // ── slide content ─────────────────────────────────────────────────────────
  static const List<_OnboardData> _slides = [
    _OnboardData(
      illustrationIndex: 0,
      title: 'Find the Right\nLawyer for You',
      subtitle:
          'Browse expert lawyers across every practice area, all in one place.',
    ),
    _OnboardData(
      illustrationIndex: 1,
      title: 'Easy To Apply\non Mobile App',
      subtitle:
          'Book consultations and send case details directly from your phone.',
    ),
    _OnboardData(
      illustrationIndex: 2,
      title: 'Over 4,000 Legal\nExperts Waiting',
      subtitle:
          'From family law to corporate cases — find exactly who you need.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _splashAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _splashFade = CurvedAnimation(
      parent: _splashAnimController,
      curve: Curves.easeIn,
    );
    _splashScale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _splashAnimController, curve: Curves.easeOutBack),
    );

    // Show splash, then animate in
    _splashAnimController.forward();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Wait for at least 1 second and check login status concurrently
    final minSplashDuration = Future.delayed(const Duration(seconds: 2));
    final checkLogin = LocalDB.instance.isUserLogin();

    final results = await Future.wait([minSplashDuration, checkLogin]);
    final isUserLogged = results[1] as bool;

    if (!mounted) return;

    if (isUserLogged) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      _exitSplash();
    }
  }

  @override
  void dispose() {
    _splashAnimController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // ── helpers ────────────────────────────────────────────────────────────────
  void _exitSplash() {
    if (!mounted) return;
    setState(() => _showSplash = false);
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _onFinish();
    }
  }

  void _onFinish() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  // ── build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      child: _showSplash
          ? _SplashView(fade: _splashFade, scale: _splashScale)
          : _OnboardingView(
              slides: _slides,
              controller: _pageController,
              currentPage: _currentPage,
              onPageChanged: (i) => setState(() => _currentPage = i),
              onNext: _nextPage,
              onSkip: _onFinish,
            ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Splash
// ─────────────────────────────────────────────────────────────────────────────
class _SplashView extends StatelessWidget {
  const _SplashView({required this.fade, required this.scale});

  final Animation<double> fade;
  final Animation<double> scale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: FadeTransition(
          opacity: fade,
          child: ScaleTransition(
            scale: scale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.darkSurface,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Icon(
                    Icons.gavel_rounded,
                    color: AppColors.primary,
                    size: 44,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'LawyerBro',
                  style: AppTextStyles.displayLarge.copyWith(
                    color: AppColors.darkSurface,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your legal partner, always.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.darkSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Onboarding pager
// ─────────────────────────────────────────────────────────────────────────────
class _OnboardingView extends StatelessWidget {
  const _OnboardingView({
    required this.slides,
    required this.controller,
    required this.currentPage,
    required this.onPageChanged,
    required this.onNext,
    required this.onSkip,
  });

  final List<_OnboardData> slides;
  final PageController controller;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final isLast = currentPage == slides.length - 1;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 680;
    final bottomPadding = isSmallScreen ? 16.0 : 36.0;
    final btnSize = isSmallScreen ? 48.0 : 56.0;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // ── Page view ──────────────────────────────────────────────────
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: slides.length,
                onPageChanged: onPageChanged,
                itemBuilder: (_, i) => _SlidePage(data: slides[i]),
              ),
            ),

            // ── Bottom controls ────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(28, 0, 28, bottomPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip
                  TextButton(
                    onPressed: onSkip,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 8,
                      ),
                    ),
                    child: Text(
                      'Skip',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),

                  // Dot indicators
                  Row(
                    children: List.generate(slides.length, (i) {
                      final active = i == currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: active ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: active
                              ? AppColors.darkSurface
                              : AppColors.border,
                          borderRadius: BorderRadius.circular(99),
                        ),
                      );
                    }),
                  ),

                  // Next / Finish button
                  GestureDetector(
                    onTap: onNext,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: btnSize,
                      height: btnSize,
                      decoration: BoxDecoration(
                        color: isLast
                            ? AppColors.primary
                            : AppColors.darkSurface,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Icon(
                        isLast
                            ? Icons.check_rounded
                            : Icons.arrow_forward_rounded,
                        color: isLast
                            ? AppColors.darkSurface
                            : AppColors.primary,
                        size: isSmallScreen ? 22 : 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Individual slide
// ─────────────────────────────────────────────────────────────────────────────
class _SlidePage extends StatelessWidget {
  const _SlidePage({required this.data});
  final _OnboardData data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenH = size.height;
    final isSmall = screenH < 680;
    final isVerySmall = screenH < 580;

    // Responsive illustration size: caps at 280, scales with screen height
    final illustrationSize = (screenH * 0.35).clamp(160.0, 280.0);

    // Responsive spacing
    final topGap = isVerySmall ? 8.0 : (isSmall ? 12.0 : 20.0);
    final midGap = isVerySmall ? 6.0 : (isSmall ? 10.0 : 14.0);
    final bottomGap = isSmall ? 12.0 : 24.0;

    // Responsive title size
    final titleSize = isVerySmall ? 22.0 : (isSmall ? 26.0 : null);
    final subtitleSize = isVerySmall ? 13.0 : (isSmall ? 14.0 : null);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Illustration ──────────────────────────────────────
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          width: illustrationSize,
                          height: illustrationSize,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: _OnboardIllustration(
                              index: data.illustrationIndex,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ── Text ───────────────────────────────────────────────
                    SizedBox(height: topGap),
                    Text(
                      data.title,
                      style: AppTextStyles.displayMedium.copyWith(
                        color: AppColors.textPrimary,
                        height: 1.2,
                        fontSize: titleSize,
                      ),
                    ),
                    SizedBox(height: midGap),
                    Text(
                      data.subtitle,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                        fontSize: subtitleSize,
                      ),
                    ),
                    SizedBox(height: bottomGap),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Custom illustrations (index-driven)
// ─────────────────────────────────────────────────────────────────────────────
class _OnboardIllustration extends StatelessWidget {
  const _OnboardIllustration({required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return switch (index) {
      0 => const _Illustration0(),
      1 => const _Illustration1(),
      _ => const _Illustration2(),
    };
  }
}

// ── Illustration 0: Lawyer researching on laptop ──────────────────────────
class _Illustration0 extends StatelessWidget {
  const _Illustration0();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background blob
          Container(
            width: 240,
            height: 240,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          // Laptop card
          Positioned(
            bottom: 20,
            child: _GlassCard(
              width: 220,
              height: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 160,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.darkSurface.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 120,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.darkSurface.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 140,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.darkSurface.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Person icon
          Positioned(
            top: 12,
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: AppColors.darkSurface,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_rounded,
                color: AppColors.primary,
                size: 46,
              ),
            ),
          ),
          // Headphones badge
          Positioned(
            top: 20,
            right: 22,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkSurface.withValues(alpha: 0.12),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Icon(
                Icons.headset_rounded,
                size: 18,
                color: AppColors.darkSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Illustration 1: Mobile app / phone ───────────────────────────────────
class _Illustration1 extends StatelessWidget {
  const _Illustration1();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background blob
          Container(
            width: 200,
            height: 250,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(60),
            ),
          ),
          // Phone mockup
          Container(
            width: 120,
            height: 220,
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkSurface.withValues(alpha: 0.25),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(height: 4),
                  // Status bar notch
                  Container(
                    width: 40,
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColors.surface.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // App content rows
                  ...List.generate(
                    5,
                    (i) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: i == 0
                                  ? AppColors.primary
                                  : AppColors.surface.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Container(
                              height: 7,
                              decoration: BoxDecoration(
                                color: AppColors.surface.withValues(
                                  alpha: i == 0 ? 0.9 : 0.2,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  // CTA button on phone
                  Container(
                    width: double.infinity,
                    height: 18,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.darkSurface,
                      size: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),
          // Floating badge: checkmark
          Positioned(
            top: 24,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkSurface.withValues(alpha: 0.10),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.success,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Applied!',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Illustration 2: Large network / briefcase ─────────────────────────────
class _Illustration2 extends StatelessWidget {
  const _Illustration2();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background
          Container(
            width: 230,
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          // Grid of case cards
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _MiniCaseCard(
                    icon: Icons.balance_rounded,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 10),
                  _MiniCaseCard(
                    icon: Icons.document_scanner_rounded,
                    color: AppColors.darkSurface,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _MiniCaseCard(
                    icon: Icons.business_center_rounded,
                    color: AppColors.darkSurface,
                  ),
                  const SizedBox(width: 10),
                  _MiniCaseCard(
                    icon: Icons.groups_rounded,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ],
          ),
          // Pill badge: 4000+
          Positioned(
            bottom: 32,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                borderRadius: BorderRadius.circular(99),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.darkSurface.withValues(alpha: 0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: AppColors.primary,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '4,000+ Legal Experts',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.surface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniCaseCard extends StatelessWidget {
  const _MiniCaseCard({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final bool isDark = color == AppColors.darkSurface;
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: isDark ? AppColors.primary : AppColors.darkSurface,
        size: 36,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared helpers
// ─────────────────────────────────────────────────────────────────────────────
class _GlassCard extends StatelessWidget {
  const _GlassCard({
    required this.width,
    required this.height,
    required this.child,
  });

  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkSurface.withValues(alpha: 0.10),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Data model
// ─────────────────────────────────────────────────────────────────────────────
class _OnboardData {
  const _OnboardData({
    required this.illustrationIndex,
    required this.title,
    required this.subtitle,
  });

  final int illustrationIndex;
  final String title;
  final String subtitle;
}
