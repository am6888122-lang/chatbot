import 'package:flutter/material.dart';
import 'create_pin_screen.dart';

class FingerprintSuccessScreen extends StatelessWidget {
  const FingerprintSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CreatePinScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.4),
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image.asset("assets/robot.png", height: 120),
              const SizedBox(height: 20),

              const Text(
                "Congratulations!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                "Your account is ready to use.\nYou will be redirected soon...",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              const CircularProgressIndicator(color: Color(0xFF00CFC1)),
            ],
          ),
        ),
      ),
    );
  }
}
