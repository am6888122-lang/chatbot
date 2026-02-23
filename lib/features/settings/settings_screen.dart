import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'language_screen.dart';
import 'security_screen.dart';
import 'help_center_screen.dart';
import 'edit_profile_screen.dart';
import 'logout_dialog.dart';

class SettingsScreen extends StatefulWidget {
  final Function(Locale) setLocale;
  const SettingsScreen({super.key, required this.setLocale});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Image Source'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
            child: const Text('Gallery'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Spacer(),
                  const Icon(Icons.more_horiz),
                ],
              ),

              const SizedBox(height: 20),

              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : AssetImage("assets/profile.jpg"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: _showImageSourceDialog,
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              const Text(
                "Andrew Ainsley",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text("andrew_ainsley@yourdomain.com"),

              const SizedBox(height: 20),
                _tile(
                context,
                Icons.person,
                AppLocalizations.of(context)!.editProfile,
                () => _go(context, const EditProfileScreen()),
              ),
              _tile(
                context,
                Icons.security,
                AppLocalizations.of(context)!.security,
                () => _go(context, const SecurityScreen()),
              ),
              _tile(
                context,
                Icons.language,
                AppLocalizations.of(context)!.language,
                () => _go(context, LanguageScreen(setLocale: widget.setLocale)),
              ),
              _tile(
                context,
                Icons.help_outline,
                AppLocalizations.of(context)!.helpCenter,
                () => _go(context, const HelpCenterScreen()),
              ),
              _tile(
                context,
                Icons.logout,
                AppLocalizations.of(context)!.logout,
                () => showLogoutDialog(context, widget.setLocale),
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _go(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  Widget _tile(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color? color,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color ?? Colors.black),
      title: Text(title, style: TextStyle(color: color ?? Colors.black)),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
