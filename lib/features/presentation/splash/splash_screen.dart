import 'package:flutter/material.dart';
import 'dart:async';

import 'splash_loading_screen.dart';

class SplashScreen extends StatefulWidget {
  final Function(Locale) setLocale;
  const SplashScreen({super.key, required this.setLocale});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SplashLoadingScreen(setLocale: widget.setLocale),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00CFC1),
      body: Center(child: Image.asset("assets/images/robot2.png", height: 350)),
    );
  }
}
