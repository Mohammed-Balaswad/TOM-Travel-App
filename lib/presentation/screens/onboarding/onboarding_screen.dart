// ignore_for_file: deprecated_member_use, must_be_immutable, unused_element_parameter

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tom_travel_app/core/theme/app_colors.dart';
import 'package:tom_travel_app/core/theme/app_text_styles.dart';
import 'package:tom_travel_app/presentation/routes/custom_transitions.dart';
import 'package:tom_travel_app/presentation/screens/auth/login/login_screen.dart';
import 'package:tom_travel_app/presentation/widgets/app_background.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final  List<_OnboardPageData> pages = [
    _OnboardPageData(
      image: 'assets/images/onboarding/Man-with-baggage.png',
      titleParts: ['Let\'s Enjoy the', 'Beautiful World!'],
      subtitle:
          'Plan, book, and enjoy every trip with ease. Hotels, flights, and attractions all in one place designed to make your travel stress-free.',
    ),
    _OnboardPageData(
      image: 'assets/images/onboarding/Man.png',
      titleParts: ['Explore Beyond', 'Limits!'],
      subtitle:
          'From breathtaking destinations to hidden gems, your journey starts with just one swipe.',
    ),
    _OnboardPageData(
      image: 'assets/images/onboarding/Women.png',
      titleParts: ['Your Journey,', 'Your Way'],
      subtitle:
          'Save favorites, track bookings, and explore the world the way you dream it.',
    ),
  ];

  void _next() {
    if (currentIndex < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // هنا تنقل لصفحة التسجيل / الرئيسية
      Navigator.push(context, SlideRightRoute(page: const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Top bar: Skip
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 48), // placeholder for back
                    TextButton(
                      onPressed: () {
                        // skip to last page or to auth
                        _controller.animateToPage(
                          pages.length - 1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text(
                        'Skip',
                        style: AppTextStyles.button.copyWith(
                          color: AppColors.lightBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // PageView (الجزء الرئيسي)
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: pages.length,
                  onPageChanged: (i) => setState(() => currentIndex = i),
                  itemBuilder: (context, index) {
                    final p = pages[index];
                    return _OnboardPage(viewData: p);
                  },
                ),
              ),

              // Indicators + Next button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24, right: 24),
                        child: TextButton(
                          onPressed: () {
                            if (currentIndex == 0) {
                              Navigator.push(context, SlideRightRoute(page: const LoginScreen()));
                            } else {
                              _controller.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            }
                          },
                          child: Text(
                            currentIndex == 0 ? 'Skip' : 'Back',
                            style:  AppTextStyles.button.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: AppColors.lightBlue,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Next button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        elevation: 6,
                      ),
                      onPressed: _next,
                      child: SvgPicture.asset(
                        currentIndex == pages.length - 1
                            ? 'assets/icons/next_icon.svg'
                            : 'assets/icons/next_icon.svg',
                        //color: AppColors.darkBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardPageData {
  final String image;
  final List<String>
  titleParts; // titleParts[0] before highlight, [1] highlighted
  final String subtitle;
  _OnboardPageData({
    required this.image,
    required this.titleParts,
    required this.subtitle,
  });
}

class _OnboardPage extends StatelessWidget {
  final _OnboardPageData viewData;
  
   _OnboardPage({super.key, required this.viewData});
  
 final List<_OnboardPageData> pages = [
    _OnboardPageData(
      image: 'assets/images/onboarding/Man-with-baggage.png',
      titleParts: ['Let\'s Enjoy the', 'Beautiful World!'],
      subtitle:
          'Plan, book, and enjoy every trip with ease. Hotels, flights, and attractions all in one place designed to make your travel stress-free.',
    ),
    _OnboardPageData(
      image: 'assets/images/onboarding/Man.png',
      titleParts: ['Explore Beyond', 'Limits!'],
      subtitle:
          'From breathtaking destinations to hidden gems, your journey starts with just one swipe.',
    ),
    _OnboardPageData(
      image: 'assets/images/onboarding/Women.png',
      titleParts: ['Your Journey,', 'Your Way'],
      subtitle:
          'Save favorites, track bookings, and explore the world the way you dream it.',
    ),
  ];
   int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final bool hasHighlight = viewData.titleParts.length > 1;
    return Column(
      children: [
        const SizedBox(height: 8),

        // hero image (rounded top)
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ClipRRect(
            //borderRadius: BorderRadius.circular(0),
            child: Image.asset(
              viewData.image,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.44,
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(height: 40),

        Padding(
          padding: const EdgeInsets.only(left: 165),
          child: Row(
            children: List.generate(pages.length, (i) {
              final isActive = i == currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: isActive ? 18 : 8,
                height: isActive ? 18 : 8,
                decoration: BoxDecoration(
                  color:
                      isActive
                          ? AppColors.mediumBlue
                          : AppColors.lightBlue.withOpacity(0.25),
                  shape: BoxShape.circle,
                  border:
                      isActive
                          ? Border.all(color: AppColors.white, width: 1.5)
                          : null,
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 20),

        // Title with highlighted rectangle behind some words
        Padding(
          padding: const EdgeInsets.only(left: 44, top: 16, right: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichTitle(
                before: viewData.titleParts[0],
                highlight: hasHighlight ? viewData.titleParts[1] : '',
              ),

              const SizedBox(height: 18),
              Text(
                viewData.subtitle,
                style: AppTextStyles.description.copyWith(
                  color: AppColors.white.withOpacity(0.8),
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Title widget that draws a small rounded rectangle highlight behind the second part
class RichTitle extends StatelessWidget {
  final String before;
  final String highlight;
  const RichTitle({super.key, required this.before, required this.highlight});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // before
        Padding(
          padding: const EdgeInsets.only(right: 0), // Beatuful highlight
          child: Text(
            before,
            style: AppTextStyles.onboarding.copyWith(
              fontSize: 26,
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 6),
        // highlight row: rectangle behind text
        if (highlight.isNotEmpty)
          Stack(
            alignment: Alignment.center,
            children: [
              // rectangle behind
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(color: AppColors.lightBlue),
                child: Text(
                  highlight,
                  style: AppTextStyles.onboarding.copyWith(
                    fontSize: 26,
                    color: AppColors.navyBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
