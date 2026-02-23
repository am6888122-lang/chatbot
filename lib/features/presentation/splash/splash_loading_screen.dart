import 'package:flutter/material.dart';
import 'dart:async';
import '../onboarding/onboarding_screen.dart';

class SplashLoadingScreen extends StatefulWidget {
  final Function(Locale) setLocale;
  const SplashLoadingScreen({super.key, required this.setLocale});

  @override
  State<SplashLoadingScreen> createState() => _SplashLoadingScreenState();
}

class _SplashLoadingScreenState extends State<SplashLoadingScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OnboardingScreen(setLocale: widget.setLocale),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/robot1.png", height: 350),
            const SizedBox(height: 60),

            const CircularProgressIndicator(color: Color(0xFF00CFC1)),
          ],
        ),
      ),
    );
  }
}
