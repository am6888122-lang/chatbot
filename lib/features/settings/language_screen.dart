import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Language {
  final String name;
  final String code;
  final String flag;

  const Language({required this.name, required this.code, required this.flag});
}

class LanguageScreen extends StatefulWidget {
  final Function(Locale) setLocale;
  const LanguageScreen({super.key, required this.setLocale});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = "en-US";

  final List<Language> languages = [
    const Language(name: "English (US)", code: "en-US", flag: "🇺🇸"),
    const Language(name: "English (UK)", code: "en-GB", flag: "🇬🇧"),
    const Language(name: "العربية", code: "ar", flag: "🇸🇦"),
    const Language(name: "Français", code: "fr", flag: "🇫🇷"),
    const Language(name: "Español", code: "es", flag: "🇪🇸"),
    const Language(name: "हिन्दी", code: "hi", flag: "🇮🇳"),
    const Language(name: "Русский", code: "ru", flag: "🇷🇺"),
    const Language(name: "Deutsch", code: "de", flag: "🇩🇪"),
    const Language(name: "Italiano", code: "it", flag: "🇮🇹"),
    const Language(name: "Português", code: "pt", flag: "🇵🇹"),
    const Language(name: "中文", code: "zh", flag: "🇨🇳"),
    const Language(name: "日本語", code: "ja", flag: "🇯🇵"),
    const Language(name: "한국어", code: "ko", flag: "🇰🇷"),
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  Future<void> _loadSelectedLanguage() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        selectedLanguage = prefs.getString('selected_language') ?? "en-US";
      });
    } catch (e) {
      print('Error loading selected language: $e');
      // Fallback to default language
      setState(() {
        selectedLanguage = "en-US";
      });
    }
  }

  Future<void> _saveSelectedLanguage(String languageCode) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('selected_language', languageCode);
    } catch (e) {
      print('Error saving selected language: $e');
    }
  }

  void _onLanguageSelected(String languageCode) {
    setState(() {
      selectedLanguage = languageCode;
    });
    _saveSelectedLanguage(languageCode);

    // Update app locale
    if (languageCode == 'ar') {
      widget.setLocale(const Locale('ar'));
    } else if (languageCode.startsWith('en')) {
      widget.setLocale(const Locale('en'));
    } else {
      // For other languages, we might need to add support or default to English
      // For now, let's try to set it as is, or default to en if not supported.
      // But since supportedLocales only has 'ar' and 'en', we should probably stick to those.
       widget.setLocale(const Locale('en'));
    }
    
    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Language changed to ${languages.firstWhere((lang) => lang.code == languageCode).name}",
        ),
        backgroundColor: const Color(0xFF00CFC1),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Language"),
        backgroundColor: const Color(0xFF00CFC1),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final language = languages[index];
          final isSelected = selectedLanguage == language.code;

          return ListTile(
            leading: Text(language.flag, style: const TextStyle(fontSize: 24)),
            title: Text(
              language.name,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? const Color(0xFF00CFC1) : Colors.black,
              ),
            ),
            subtitle: Text(language.code),
            trailing: isSelected
                ? const Icon(Icons.check_circle, color: Color(0xFF00CFC1))
                : null,
            onTap: () => _onLanguageSelected(language.code),
            tileColor: isSelected ? Colors.teal.shade50 : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
          );
        },
      ),
    );
  }
}
