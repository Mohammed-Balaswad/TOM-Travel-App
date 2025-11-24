// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tom_travel_app/data/repositories/auth_repository.dart';
import 'package:tom_travel_app/logic/cubits/auth_cubit.dart';
import 'package:tom_travel_app/presentation/routes/app_routes.dart';
import 'package:tom_travel_app/presentation/screens/profile/profile_screen.dart';

void main() {
  final authRepository = AuthRepository();

  runApp(
  MultiBlocProvider(
    providers: [
      BlocProvider<AuthCubit>(
        create: (_) => AuthCubit(authRepository),
      ),
    ],
    child: TomTravelApp(appRouter: AppRouter()),
  ),
);

}


class TomTravelApp extends StatelessWidget {
  final AppRouter _appRouter;

  const TomTravelApp({super.key, required AppRouter appRouter})
      : _appRouter = appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tom Travel',
      onGenerateRoute: _appRouter.generateRoute,
      initialRoute: '/',
    );
  }
}

