import 'package:flutter/material.dart';
import '../../core/primary_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Create your\nAccount",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 30),

                _inputField(Icons.email, "Email"),
                const SizedBox(height: 16),
                _inputField(Icons.lock, "Password", isPassword: true),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Checkbox(value: true, onChanged: (v) {}),
                    const Text("Remember me"),
                  ],
                ),

                const SizedBox(height: 20),

                PrimaryButton(text: "Sign up", onTap: () {}),

                const SizedBox(height: 20),

                const Center(child: Text("or continue with")),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialIcon(Icons.facebook),
                    _socialIcon(Icons.g_mobiledata),
                    _socialIcon(Icons.apple),
                  ],
                ),

                const SizedBox(height: 20), // Added to prevent bottom overflow

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          "Sign in",
                          style: TextStyle(color: Color(0xFF00CFC1)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField(IconData icon, String hint, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.grey.shade200,
        child: Icon(icon),
      ),
    );
  }
}
