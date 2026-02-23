import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, bool>> messages = [];

  // Use the provided API Key
  static const String apiKey = '';

  late final GenerativeModel _model;
  late final ChatSession _chatSession;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() {
    // Initial dummy messages from bot
    messages.addAll([
      {"Hello Andrew! I'm El Mido 😄": false},
      {"How are you today??": false},
    ]);

    // Initialize Gemini Model
    // Initialize Gemini Model
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      systemInstruction: Content.system(
        'You are Bobo, a helpful, friendly, and intelligent AI assistant. You answer questions concisely and professionally.',
      ),
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
      ],
      generationConfig: GenerationConfig(
        temperature: 0.7,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 2048,
      ),
    );

    // Initialize Chat Session with empty history to start fresh and avoid role conflicts
    _chatSession = _model.startChat();
  }

  Future<void> sendMessage() async {
    if (controller.text.isNotEmpty && !_isLoading) {
      final userMessage = controller.text;
      setState(() {
        messages.add({userMessage: true});
        _isLoading = true;
      });
      controller.clear();
      _scrollToBottom();

      try {
        final response = await _chatSession.sendMessage(
          Content.text(userMessage),
        );

        final text = response.text;
        if (text != null) {
          setState(() {
            messages.add({text: false});
            _isLoading = false;
          });
          _scrollToBottom();
        } else {
          setState(() {
            messages.add({"I didn't understand that.": false});
            _isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          messages.add({"Error: ${e.toString()}": false});
          _isLoading = false;
        });
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Text(
                    "El Mido",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const Spacer(),
                  const Icon(Icons.search),
                  const SizedBox(width: 12),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) {
                      if (value == "clear") {
                        _clearChat();
                      } else if (value == "export") {
                        _exportChat();
                      } else if (value == "end") {
                        _showEndSessionDialog();
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: "clear",
                        child: ListTile(
                          leading: Icon(Icons.close),
                          title: Text("Clear Chat"),
                        ),
                      ),
                      const PopupMenuItem(
                        value: "export",
                        child: ListTile(
                          leading: Icon(Icons.download),
                          title: Text("Export Chat"),
                        ),
                      ),
                      const PopupMenuItem(
                        value: "end",
                        child: ListTile(
                          leading: Icon(Icons.logout),
                          title: Text("End Session"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: messages.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == messages.length) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF00CFC1),
                          ),
                        ),
                      ),
                    );
                  }

                  String text = messages[index].keys.first;
                  bool isUser = messages[index].values.first;

                  return Align(
                    alignment: isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isUser
                            ? Color(0xFF00CFC1)
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: MarkdownBody(
                        data: text,
                        styleSheet: MarkdownStyleSheet(
                          p: TextStyle(
                            color: isUser ? Colors.white : Colors.black,
                          ),
                          code: TextStyle(
                            backgroundColor: isUser
                                ? Colors.white24
                                : Colors.white,
                            color: isUser ? Colors.white : Colors.black,
                          ),
                          codeblockDecoration: BoxDecoration(
                            color: isUser
                                ? Colors.white12
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Type a message to El Mido ...",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Color(0xFF00CFC1),
                    child: IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clearChat() {
    setState(() {
      messages.clear();
    });
  }

  void _exportChat() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Chat Exported Successfully")));
  }

  void _showEndSessionDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Column(
          children: [
            Image.asset("assets/images/robot7.png", height: 100),
            const SizedBox(height: 10),
            const Text(
              "End Session",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: const Text(
          "Are you sure you want to end session the chat with El Mido?",
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00CFC1),
                minimumSize: const Size(240, 48),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("Yes, End Session"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(240, 48)),
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ),
        ],
      ),
    );
  }
}
