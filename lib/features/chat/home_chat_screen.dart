import 'package:chatbot/features/chat/start_chat_screen.dart';
import '../../l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';

class HomeChatScreen extends StatelessWidget {
  final Function(Locale) setLocale;
  const HomeChatScreen({super.key, required this.setLocale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Image.asset("assets/robot.png", height: 34),
                  const SizedBox(width: 8),
                  const Text(
                    "El Mido",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const Icon(Icons.notifications_none),
                  const SizedBox(width: 12),
                  const Icon(Icons.settings),
                ],
              ),

              const SizedBox(height: 20),

              Text(
                AppLocalizations.of(context)!.activeChats,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              _chatTile(
                context,
                title: "El Mido",
                message: "Hello Andrew! I'm El Mido 😄 How are you today??",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChatScreen()),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.endedChats,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    AppLocalizations.of(context)!.seeAll,
                    style: const TextStyle(color: Color(0xFF00CFC1)),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              _chatTile(
                context,
                title: "El Mido - Dec 19, 2024",
                message: "I'm good too, I'm reading a book right now 😌",
              ),
              _chatTile(
                context,
                title: "El Mido - Dec 18, 2024",
                message: "El Mido is very sad today because of an accident",
              ),
              _chatTile(
                context,
                title: "El Mido - Dec 18, 2024",
                message:
                    "Hi, how are you today? I'm ready to accompany your day!",
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
                    MaterialPageRoute(
                      builder: (_) => StartChatScreen(setLocale: setLocale),
                    ),
                  );
                },
                child: Text(AppLocalizations.of(context)!.startAnotherChat),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chatTile(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            // Image.asset("assets/robot.png", height: 46),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(message, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const Icon(Icons.chat_bubble_outline, color: Color(0xFF00CFC1)),
          ],
        ),
      ),
    );
  }
}
