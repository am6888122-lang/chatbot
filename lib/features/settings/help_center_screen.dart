import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Help Center"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "FAQ"),
              Tab(text: "Contact us"),
            ],
          ),
        ),
        body: const TabBarView(children: [FAQTab(), ContactTab()]),
      ),
    );
  }
}

class FAQTab extends StatelessWidget {
  const FAQTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _faq("What is El Mido?"),
        _faq("How to use El Mido?"),
        _faq("Is El Mido free to use?"),
        _faq("How to delete chat?"),
      ],
    );
  }

  Widget _faq(String title) {
    return ExpansionTile(
      title: Text(title),
      children: const [
        Padding(
          padding: EdgeInsets.all(12),
          child: Text("Lorem ipsum dolor sit amet..."),
        ),
      ],
    );
  }
}

class ContactTab extends StatelessWidget {
  const ContactTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      "WhatsApp",
      "Website",
      "Facebook",
      "Twitter",
      "Instagram",
    ];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: const Icon(Icons.link, color: Color(0xFF00CFC1)),
          title: Text(items[i]),
        );
      },
    );
  }
}
