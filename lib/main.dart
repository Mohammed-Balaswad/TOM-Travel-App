// import 'package:flutter/material.dart';
// import 'package:tom_travel_app/presentation/screens/auth/login/login_screen.dart';
// import 'package:tom_travel_app/presentation/screens/auth/signup/signup_screen.dart';
// import 'package:tom_travel_app/presentation/screens/explore/explore_screen.dart';
// import 'package:tom_travel_app/presentation/screens/onboarding/onboarding_screen.dart';


// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Travel Companion',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       home: const ExploreScreen(),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tom_travel_app/presentation/screens/auth/login/login_screen.dart';
import 'package:tom_travel_app/presentation/screens/auth/signup/signup_screen.dart';
import 'package:tom_travel_app/presentation/screens/explore/explore_screen.dart';
import 'package:tom_travel_app/presentation/screens/splash/splash_screen.dart';
import 'data/repositories/auth_repository.dart';
import 'logic/cubits/auth_cubit.dart';
import 'presentation/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository = AuthRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
      // intialRoute: (_) => SplashScreen(),
       // '/' : (_) => SplashScreen(),
        '/login': (_) => BlocProvider(
              create: (_) => AuthCubit(_authRepository),
              child: LoginScreen(),
            ),
            '/signup': (_) => BlocProvider(
              create: (_) => AuthCubit(_authRepository),
              child: SignupScreen(),
            ),
        '/home': (_) => ExploreScreen(),
      },
      initialRoute: '/login',
    );
  }
}
