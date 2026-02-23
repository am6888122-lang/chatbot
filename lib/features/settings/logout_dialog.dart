import 'package:chatbot/features/auth/login_screen.dart';
import 'package:chatbot/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

void showLogoutDialog(BuildContext context, Function(Locale) setLocale) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: Text(AppLocalizations.of(context)!.logout),
      content: Text(AppLocalizations.of(context)!.logoutConfirmation),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00CFC1),
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen(setLocale: setLocale)),
              (route) => false,
            );
          },
          child: Text(AppLocalizations.of(context)!.yesLogout),
        ),
      ],
    ),
  );
}
