import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial',
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
        ),
      ),
      home: ChatBotPage(),
    );
  }
}

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  ChatBotPageState createState() => ChatBotPageState();
}

class ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final List<String> _responses = [
    "Hello! How can I assist you today?",
    "Sure, let me help you with that.",
    "I'm here to answer your questions.",
    "Tell me more about what you need.",
    "Let's solve that together!"
  ];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({"user": _controller.text});
        _controller.clear();
        _botResponse();
      });
    }
  }

  void _botResponse() {
    setState(() {
      _messages.add({"bot": _responses[_messages.length % _responses.length]});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AI ChatBot',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                bool isBot = _messages[index].containsKey("bot");
                return ListTile(
                  title: Text(
                    isBot ? _messages[index]["bot"]! : _messages[index]["user"]!,
                    style: TextStyle(fontSize: 20.0, color: isBot ? Colors.blue : Colors.black),
                    textAlign: isBot ? TextAlign.left : TextAlign.right,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Type your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.yellowAccent,
    );
  }
}
