// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tom_travel_app/core/theme/app_colors.dart';
import 'package:tom_travel_app/core/theme/app_text_styles.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tom_travel_app/presentation/widgets/bottom_navigation_bar.dart';
import '../../widgets/app_background.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
  
    return Scaffold(
      resizeToAvoidBottomInset: false, // لمنع طلوع البار فوق الكيبورد
      body: AppBackground(
        child: Stack(
          children: [
            //  الدائرة البيضاء في الأعلى (ثابتة)
            Positioned(
              top: -size.width * 0.4,
              left: -size.width * 0.1,
              child: Container(
                width: size.width * 1.2,
                height: size.width * 1.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(size.width * 0.6),
                    topRight: Radius.circular(size.width * 0.6),
                    bottomLeft: Radius.circular(size.width * 0.5),
                    bottomRight: Radius.circular(size.width * 0.5),
                  ),
                ),
              ),
            ),

            //  المحتوى الكامل داخل SafeArea و Column
            SafeArea(
              child: Column(
                children: [
                  _buildHeaderSection(context).animate()
                      .fade(duration: 600.ms, delay: 300.ms)
                      .slideY(begin: 0.2),
                  const SizedBox(height: 30),
                  _buildSearchSection(context).animate()
                          .fade(duration: 600.ms, delay: 500.ms)
                          .slideY(begin: 0.2),
                  const SizedBox(height: 50),
                  

                  //  المحتوى المتحرك داخل ShaderMask لتأثير التلاشي
                  Expanded(
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent, 
                            Colors.white, 
                          ],
                          stops: [
                            0.0,
                            0.11,
                          ],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstIn,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: size.width * 0.11),
                            _buildCategoriesSection(context).animate()
                          .fade(duration: 600.ms, delay: 700.ms)
                          .slideY(begin: 0.2),
                            const SizedBox(height: 40),
                            _buildPopularDestinationsSection(context).animate()
                          .fade(duration: 600.ms, delay: 900.ms)
                          .slideY(begin: 0.2),
                            const SizedBox(height: 30),
                            _buildTopHotelsSection(context).animate()
                          .fade(duration: 600.ms, delay: 1100.ms)
                          .slideY(begin: 0.2),
                            const SizedBox(height: 50),
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                   CustomBottomNavBar(
                    currentIndex: selectedIndex,
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ).animate()
                          .fade(duration: 600.ms, delay: 1400.ms)
                          .slideY(begin: 0.2),
                ],
              ),
            ),
          ],
        ),
      ),
      

      
    );
  }

  // ---------------- Header Section ----------------
  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Find your",
                style: AppTextStyles.heading.copyWith(
                  color: AppColors.navyBlue,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "favorite place",
                style: AppTextStyles.heading.copyWith(
                  color: AppColors.navyBlue,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[50],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                'assets/icons/notifications_icon.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Search Section ----------------
  Widget _buildSearchSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(color: AppColors.navyBlue),
              decoration: InputDecoration(
                hintText: "Search Destination, Hotels ...",
                hintStyle: AppTextStyles.button.copyWith(
                  color: AppColors.mediumBlue.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset('assets/icons/search_icon.svg'),
                ),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.2),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: AppColors.mediumBlue,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: SvgPicture.asset('assets/icons/filter_icon.svg'),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Categories Section ----------------
  Widget _buildCategoriesSection(BuildContext context) {
    final categories = [
      {'icon': 'assets/icons/sleeping.svg', 'label': 'Hotels'},
      {'icon': 'assets/icons/plane3.svg', 'label': 'Flights'},
      {'icon': 'assets/icons/food.svg', 'label': 'Restaurants'},
      {'icon': 'assets/icons/camera.svg', 'label': 'Attractions'},
    ];

    return SizedBox(
      height: 100,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(width: 29),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return GestureDetector(
            onTap: () {
              //! منطق الفئات؟
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        cat['icon']!,
                        width: 46,
                        height: 46,
                        color: AppColors.mediumBlue,
                        // colorFilter:
                        //     const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  cat['label']!,
                  style: AppTextStyles.heading.copyWith(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ---------------- Popular Destinations ----------------
  Widget _buildPopularDestinationsSection(BuildContext context) {
    final destinations = [
      {
        'image': 'assets/images/destinations/Reykjavík.png',
        'city': 'Reykjavik',
        'country': 'Iceland',
        'rating': '4.9',
      },
      {
        'image': 'assets/images/destinations/Oia, Santorini.png',
        'city': 'Oia, Santorini',
        'country': 'Greece',
        'rating': '4.8',
      },
      {
        'image': 'assets/images/destinations/Dubai.png',
        'city': 'Dubai',
        'country': 'UAE',
        'rating': '4.6',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Popular Destinations"),
        const SizedBox(height: 8),
        SizedBox(
          height: 240,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemCount: destinations.length,
            itemBuilder: (context, index) {
              final item = destinations[index];
              return GestureDetector(
                onTap: () {
                  //! منطق الوجهة
                },
                child: Container(
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    image: DecorationImage(
                      image: AssetImage(item['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // تدرج غامق أسفل الصورة
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                AppColors.darkBlue.withOpacity(0.3),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // التقييم + المفضلة
                      Positioned(
                        top: 10,
                        left: 10,
                        right: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.45),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.4),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/star_icon.svg',
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    item['rating']!,
                                    style: AppTextStyles.heading.copyWith(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 26,
                              width: 26,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.4),
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SvgPicture.asset(
                                  'assets/icons/white_hart_icon.svg',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // البلد + المدينة
                      Positioned(
                        left: 10,
                        bottom: 12,
                        right: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/location_icon.svg',
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  item['country']!,
                                  style: AppTextStyles.heading.copyWith(
                                    color: Colors.white70,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              item['city']!,
                              style: AppTextStyles.heading.copyWith(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ---------------- Top Hotels ----------------
  Widget _buildTopHotelsSection(BuildContext context) {
    final destinations = [
      {
        'image': 'assets/images/hotels/Paradise.png',
        'hotel': 'Paradise',
        'country': 'Greece',
        'rating': '4.9',
      },
      {
        'image': 'assets/images/hotels/Vila-lenu.png',
        'hotel': 'Villa lenu',
        'country': 'Canggu, Bali',
        'rating': '4.8',
      },
      {
        'image': 'assets/images/hotels/Hotel-de-Paris.jpg',
        'hotel': 'Hotel de Paris',
        'country': 'Paris',
        'rating': '4.6',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Top Hotels"),
        const SizedBox(height: 8),
        SizedBox(
          height: 240,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemCount: destinations.length,
            itemBuilder: (context, index) {
              final item = destinations[index];
              return GestureDetector(
                onTap: () {
                  //! منطق الوجهة
                },
                child: Container(
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    image: DecorationImage(
                      image: AssetImage(item['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // تدرج غامق أسفل الصورة
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                AppColors.darkBlue.withOpacity(0.3),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // التقييم + المفضلة
                      Positioned(
                        top: 10,
                        left: 10,
                        right: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.45),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.4),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/star_icon.svg',
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    item['rating']!,
                                    style: AppTextStyles.heading.copyWith(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 26,
                              width: 26,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.4),
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SvgPicture.asset(
                                  'assets/icons/white_hart_icon.svg',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // البلد + المدينة
                      Positioned(
                        left: 10,
                        bottom: 12,
                        right: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/location_icon.svg',
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  item['country']!,
                                  style: AppTextStyles.heading.copyWith(
                                    color: Colors.white70,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              item['hotel']!,
                              style: AppTextStyles.heading.copyWith(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ---------------- Helper: Section Title ----------------
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.heading.copyWith(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          TextButton(
            onPressed: () {
              //! منطق عرض الكل
            },
            child: Text(
              "View All",
              style: AppTextStyles.heading.copyWith(
                color: AppColors.lightBlue,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
