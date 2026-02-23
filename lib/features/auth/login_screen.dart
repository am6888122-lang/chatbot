import 'package:chatbot/features/auth/forgotpassword/forgot_method_screen.dart';
import 'package:chatbot/features/chat/start_chat_screen.dart';
import '../../l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/primary_button.dart';

class LoginScreen extends StatelessWidget {
  final Function(Locale) setLocale;
  const LoginScreen({super.key, required this.setLocale});

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

                Text(
                  AppLocalizations.of(context)!.loginToYourAccount,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                _inputField(Icons.email, AppLocalizations.of(context)!.email),
                const SizedBox(height: 16),
                _inputField(
                  Icons.lock,
                  AppLocalizations.of(context)!.password,
                  isPassword: true,
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Checkbox(value: true, onChanged: (v) {}),
                    Text(AppLocalizations.of(context)!.rememberMe),
                  ],
                ),

                const SizedBox(height: 20),

                PrimaryButton(
                  text: AppLocalizations.of(context)!.signIn,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StartChatScreen(setLocale: setLocale),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ForgotMethodScreen(),
                        ),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.forgotPassword,
                      style: const TextStyle(color: Color(0xFF00CFC1)),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Center(
                  child: Text(AppLocalizations.of(context)!.orContinueWith),
                ),

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
                      Text(
                        "${AppLocalizations.of(context)!.dontHaveAccount} ",
                      ), // Added space manually or rely on arb
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          AppLocalizations.of(context)!.signup,
                          style: const TextStyle(color: Color(0xFF00CFC1)),
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
