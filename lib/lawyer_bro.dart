import 'package:flutter/material.dart';
import 'package:lawyer_bro/features/home/screens/home_navbar.dart';
import 'package:lawyer_bro/features/onboard_screen.dart';
import 'package:lawyer_bro/features/authentication/screens/login.dart';
import 'package:lawyer_bro/features/authentication/screens/register.dart';
import 'package:lawyer_bro/styles/theme.dart';

class LawyerBroApp extends StatelessWidget {
  const LawyerBroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LawyerBro',
      theme: AppTheme.light,
      //  darkTheme: AppTheme.dark,
      // themeMode: ThemeMode.system,
      home: const OnBoardScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeNavbar(),
      },
    );
  }
}
