import 'package:flutter/material.dart';
import 'create_new_password_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = "";

  void add(String n) {
    if (otp.length < 4) setState(() => otp += n);
  }

  void remove() {
    if (otp.isNotEmpty) setState(() => otp = otp.substring(0, otp.length - 1));
  }

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

              const SizedBox(height: 10),

              const Text(
                "Forgot Password",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text("Code has been sent to +1 111 ******99"),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: index == otp.length
                            ? Color(0xFF00CFC1)
                            : Colors.grey,
                      ),
                    ),
                    child: Text(
                      index < otp.length ? otp[index] : "",
                      style: const TextStyle(fontSize: 20),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              Text(
                "Resend code in 53 s",
                style: TextStyle(color: Color(0xFF00CFC1)),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00CFC1),
                  minimumSize: const Size(double.infinity, 54),
                ),
                onPressed: otp.length == 4
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CreateNewPasswordScreen(),
                          ),
                        );
                      }
                    : null,
                child: const Text("Verify"),
              ),

              const SizedBox(height: 20),

              Expanded(child: _numberPad()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _numberPad() {
    List<String> keys = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "*",
      "0",
      "⌫",
    ];

    return GridView.builder(
      itemCount: keys.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        String key = keys[index];

        return GestureDetector(
          onTap: () {
            if (key == "⌫")
              remove();
            else if (key != "*")
              add(key);
          },
          child: Center(child: Text(key, style: const TextStyle(fontSize: 22))),
        );
      },
    );
  }
}
