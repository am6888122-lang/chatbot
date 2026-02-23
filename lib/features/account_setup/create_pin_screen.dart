import 'package:flutter/material.dart';
import 'fill_profile_screen.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  String pin = "";

  void addNumber(String number) {
    if (pin.length < 4) {
      setState(() => pin += number);
    }
  }

  void removeNumber() {
    if (pin.isNotEmpty) {
      setState(() => pin = pin.substring(0, pin.length - 1));
    }
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

              const SizedBox(height: 20),

              const Text(
                "Create New PIN",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text("Add a PIN number to make your account more secure."),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Color(0xFF00CFC1)),
                    ),
                    child: Text(
                      index < pin.length ? "●" : "",
                      style: const TextStyle(fontSize: 22),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 40),

              Expanded(child: _numberPad()),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00CFC1),
                  minimumSize: const Size(double.infinity, 54),
                ),
                onPressed: pin.length == 4
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const FillProfileScreen(),
                          ),
                        );
                      }
                    : null,
                child: const Text("Continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _numberPad() {
    return GridView.builder(
      itemCount: 12,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
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

        String key = keys[index];

        return GestureDetector(
          onTap: () {
            if (key == "⌫")
              removeNumber();
            else if (key != "*")
              addNumber(key);
          },
          child: Center(child: Text(key, style: const TextStyle(fontSize: 22))),
        );
      },
    );
  }
}
