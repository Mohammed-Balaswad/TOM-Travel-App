import 'package:flutter/material.dart';
import 'package:tom_travel_app/presentation/screens/auth/login/login_screen.dart';
import 'package:tom_travel_app/presentation/screens/auth/signup/signup_screen.dart';
import 'package:tom_travel_app/presentation/screens/explore/explore_screen.dart';
import 'package:tom_travel_app/presentation/screens/onboarding/onboarding_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Companion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ExploreScreen(),
    );
  }
}
