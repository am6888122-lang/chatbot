import 'package:flutter/material.dart';
import 'otp_screen.dart';

class ForgotMethodScreen extends StatelessWidget {
  const ForgotMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
              ),

              Image.asset("assets/images/robot6.png", height: 160),
              const SizedBox(height: 20),

              const Text(
                "Forgot Password",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text(
                "Select which contact details should we use to reset your password",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              _methodCard(Icons.sms, "via SMS", "+1 111 ******99", true),
              _methodCard(
                Icons.email,
                "via Email",
                "and***ley@yourdomain.com",
                false,
              ),

              const Spacer(),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00CFC1),
                  minimumSize: const Size(double.infinity, 56),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const OtpScreen()),
                  );
                },
                child: const Text("Continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _methodCard(IconData icon, String title, String value, bool selected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: selected ? Color(0xFF00CFC1) : Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: Icon(icon, color: Color(0xFF00CFC1)),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(value),
            ],
          ),
        ],
      ),
    );
  }
}
