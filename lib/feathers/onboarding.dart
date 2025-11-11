
import 'package:flutter/material.dart';
import 'package:mee_safe/feathers/auth/view/login_screen.dart';
import 'package:mee_safe/feathers/constants/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<_OnboardPageData> pages = [
    _OnboardPageData(
      title: 'Welcome to MeeSafe',
      subtitle:
          'Your one-stop app to register, manage, and protect all your mobile warranties. Stay worry-free with ClaimSure!',
      imageUrl: 'assets/onboard/onboard_image_1.jpg',
    ),
    _OnboardPageData(
      title: 'Smart Warranty Checks',
      subtitle:
          'Select your device, enter IMEI, and we’ll instantly verify claim eligibility — 30-day limit and valid manufacturing year ensured.',
      imageUrl: 'assets/onboard/onboard_image_2.jpg',
    ),
    _OnboardPageData(
      title: 'Get Started',
      subtitle:
          'Register your mobile, save warranty details, and manage claims with ease — all from one secure place.',
      imageUrl: 'assets/onboard/onboard_image_3.jpg',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _goToHome() {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => LoginScreen()),
  );
}


  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
      child: Row(
        children: [
          const Spacer(),
          TextButton(
            onPressed: _goToHome,
            child: const Text(
              'Skip',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(_OnboardPageData data) {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Image.asset(
              data.imageUrl,
              fit: BoxFit.contain,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.broken_image, size: 64),
                );
              },
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 28, right: 28, top: 28, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  data.subtitle,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
      child: Row(
        children: [
          SmoothPageIndicator(
            controller: _controller,
            count: pages.length,
            effect: const ExpandingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: AppColors.primary,
            ),
            onDotClicked: (index) {
              _controller.animateToPage(
                index,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              if (_currentPage == pages.length - 1) {
                _goToHome();
              } else {
                _controller.nextPage(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 12.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              _currentPage == pages.length - 1 ? 'Get Started' : 'Next',style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildPage(pages[index]);
                },
              ),
            ),
            _buildBottomControls(),
          ],
        ),
      ),
    );
  }
}

class _OnboardPageData {
  final String title;
  final String subtitle;
  final String imageUrl;
  const _OnboardPageData({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}
