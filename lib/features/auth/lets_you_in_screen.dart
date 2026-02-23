import 'package:flutter/material.dart';
import '../../core/primary_button.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'widgets/widget_social_button/social_button.dart';

class LetsYouInScreen extends StatelessWidget {
  final Function(Locale) setLocale;
  const LetsYouInScreen({super.key, required this.setLocale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  // child: IconButton(
                  //   onPressed: () => Navigator.pop(context),
                  //   icon: const Icon(Icons.arrow_back),
                  // ),
                ),

                const SizedBox(height: 90),

                Image.asset(
                  "assets/images/robot6.png",
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                const SizedBox(height: 20),

                const Text(
                  "Let's you in",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 30),

                SocialButton(
                  text: "Continue with Facebook",
                  icon: Icons.facebook,
                  onTap: () {},
                ),

                SocialButton(
                  text: "Continue with Google",
                  icon: Icons.g_mobiledata,
                  onTap: () {},
                ),

                SocialButton(
                  text: "Continue with Apple",
                  icon: Icons.apple,
                  onTap: () {},
                ),

                const SizedBox(height: 20),

                const Text("or"),

                const SizedBox(height: 20),

                PrimaryButton(
                  text: "Sign in with password",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoginScreen(setLocale: setLocale),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20), // Added to prevent bottom overflow

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Color(0xFF00CFC1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
