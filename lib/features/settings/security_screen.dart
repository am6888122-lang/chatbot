import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import '../account_setup/create_pin_screen.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool rememberMe = true;
  bool biometric = false;
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _checkBiometricSupport();
  }

  Future<void> _checkBiometricSupport() async {
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      List<BiometricType> availableBiometrics = await auth
          .getAvailableBiometrics();
      setState(() {
        biometric = canCheckBiometrics && availableBiometrics.isNotEmpty;
      });
    } catch (e) {
      print('Error checking biometrics: $e');
    }
  }

  Future<void> _authenticateBiometric() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to enable biometric ID',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (authenticated) {
        setState(() => biometric = true);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Biometric ID enabled')));
      } else {
        setState(() => biometric = false);
      }
    } catch (e) {
      print('Error authenticating: $e');
      setState(() => biometric = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Biometric authentication failed')),
      );
    }
  }

  void _changePassword() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00CFC1),
            ),
            onPressed: () {
              // TODO: Implement password change logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password changed successfully')),
              );
            },
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Security")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SwitchListTile(
            value: rememberMe,
            title: const Text("Remember me"),
            onChanged: (v) => setState(() => rememberMe = v),
            activeColor: const Color(0xFF00CFC1),
          ),
          SwitchListTile(
            value: biometric,
            title: const Text("Biometric ID"),
            onChanged: (v) async {
              if (v) {
                await _authenticateBiometric();
              } else {
                setState(() => biometric = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Biometric ID disabled')),
                );
              }
            },
            activeColor: const Color(0xFF00CFC1),
          ),
          const SizedBox(height: 20),
          _button("Change PIN", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreatePinScreen()),
            );
          }),
          _button("Change Password", _changePassword),
        ],
      ),
    );
  }

  Widget _button(String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00CFC1),
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
