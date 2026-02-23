import 'package:chatbot/features/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';

class StartChatScreen extends StatelessWidget {
  final Function(Locale) setLocale;
  const StartChatScreen({super.key, required this.setLocale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 40),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SettingsScreen(setLocale: setLocale),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 40),

              Image.asset("assets/images/robot1.png", height: 400, width: 500),
              const SizedBox(height: 20),

              const Text(
                "Welcome, Andrew! 👋",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),

              const Text(
                "Let's Have Fun with El Mido!\nStart a conversation with El Mido right now!",
                textAlign: TextAlign.center,
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
                    MaterialPageRoute(builder: (_) => const ChatScreen()),
                  );
                },
                child: const Text("Start Chat with El Mido"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
