import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tom_travel_app/core/theme/app_colors.dart';
import 'package:tom_travel_app/core/theme/app_text_styles.dart';
import 'package:tom_travel_app/presentation/routes/custom_transitions.dart';
import 'package:tom_travel_app/presentation/screens/auth/signup/signup_screen.dart';
import 'package:tom_travel_app/presentation/widgets/app_background.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tom_travel_app/presentation/widgets/auth_button.dart';
import 'package:tom_travel_app/presentation/widgets/auth_fields.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //final topAreaHeight = size.width * 0.9;

    return Scaffold(
      body: AppBackground(
        child: Stack(
          children: [
            // شكل نصف الدائرة البيضاء في الأعلى
            Positioned(
              top: -size.width * 0.4,
              left: -size.width * 0.1,
              child: Container(
                width: size.width * 1.2,
                height: size.width * 1.3,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // المحتوى الرئيسي
            SafeArea(
              child: Column(
                children: [
                  // الشعار
                  Transform.translate(
                    offset: const Offset(0, 20), // ← تحريك للأعلى بمقدار 40px
                    child: Column(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: SvgPicture.asset(
                            'assets/icons/secondary_blue_logo_icon.svg',
                          ),                      
                        ).animate()
                         .fade(duration: 1000.ms)
                          .slideY(begin: 0.3, end: 0, curve: Curves.easeOut),

                        const SizedBox(height: 20),

                        Text(
                          'Welcome Back,',
                          style: AppTextStyles.subtitle.copyWith(
                            color: AppColors.navyBlue,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ).animate()
                          .fade(duration: 600.ms, delay: 300.ms)
                          .slideY(begin: 0.2),

                        const SizedBox(height: 8),

                        Text(
                          'your next adventure awaits!',
                          style: AppTextStyles.subtitle.copyWith(
                            color: AppColors.navyBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ).animate()
                           .fade(duration: 600.ms, delay: 500.ms)
                           .slideY(begin: 0.2),
                      ],
                    ),
                  ),
                  const SizedBox(height: 150),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 5,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 6),
                            
                            // حقل البريد الإلكتروني
                            buildField(
                              label: 'Email',
                              icon: Icons.email_outlined,
                              hint: 'Enter your email',
                            ).animate()
                              .fade(duration: 600.ms, delay: 700.ms)
                              .slideY(begin: 0.3),

                            const SizedBox(height: 18),

                            // حقل كلمة المرور
                             buildField(
                              label: 'Password',
                              icon: Icons.lock_outline,
                              hint: 'Enter your password',
                              obscure: true,
                            ).animate()
                               .fade(duration: 600.ms, delay: 900.ms)
                               .slideY(begin: 0.3),

                            const SizedBox(height: 0),

                            // زر نسيت كلمة المرور
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: AppTextStyles.button.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ).animate()
                               .fade(duration: 600.ms, delay: 900.ms)
                               .slideY(begin: 0.3),

                            const SizedBox(height: 28),

                            // زر تسجيل الدخول
                            buildButton('Login').animate()
                               .fade(duration: 700.ms, delay: 1100.ms)
                               .scale(begin: const Offset(0.95, 0.95), curve: Curves.easeOutBack),

                            const SizedBox(height: 40),

                            // أو تسجيل الدخول عبر
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 150,
                                  height: 0.5,
                                  color: AppColors.white.withOpacity(0.5),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'or',
                                  style: AppTextStyles.button.copyWith(
                                    color: AppColors.white.withOpacity(0.5),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 150,
                                  height: 0.5,
                                  color: AppColors.white.withOpacity(0.5),
                                ),
                              ],
                            ).animate()
                               .fade(duration: 600.ms, delay: 1200.ms)
                               .slideY(begin: 0.3),
                            const SizedBox(height: 24),

                            // أزرار تسجيل الدخول الاجتماعية
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                socialButton('assets/icons/google.svg'),
                                const SizedBox(width: 30),
                                socialButton('assets/icons/apple.svg'),
                              ],
                            ).animate()
                               .fade(duration: 600.ms, delay: 1300.ms)
                               .slideY(begin: 0.2),

                            const SizedBox(height: 32),

                            // زر الانتقال إلى التسجيل
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: AppTextStyles.button.copyWith(
                                    color: AppColors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),

                                TextButton(
                                  style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size(100, 40),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                  onPressed: () {
                                    Navigator.push(context, SlideRightRoute(page: const SignupScreen()));
                                  },

                                  child: Text(
                                    'Sign Up Here',
                                    style: AppTextStyles.button.copyWith(
                                      color: AppColors.lightBlue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ).animate()
                               .fade(duration: 600.ms, delay: 1500.ms)
                               .slideY(begin: 0.2),
                          ],
                        ),
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
