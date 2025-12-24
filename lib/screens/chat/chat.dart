import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hey! What are you cooking today?',
      'isMe': false,
      'time': '09:32 AM',
    },
    {
      'text': 'Not sure yet 😅 Any quick recipe ideas?',
      'isMe': true,
      'time': null,
    },
    {
      'text': 'How about chicken fried rice? It\'s easy and tasty.',
      'isMe': false,
      'time': '09:32 AM',
    },
    {
      'text': 'Sounds good! What do I need for that?',
      'isMe': true,
      'time': null,
    },
    {
      'text': 'Just some rice, chicken, eggs, soy sauce, and a few veggies.',
      'isMe': false,
      'time': '09:32 AM',
    },
    {
      'text': 'Nice! How long do you think it will take to prepare?',
      'isMe': true,
      'time': null,
    },
  ];

  final TextEditingController _controller = TextEditingController();

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final bool isMe = message['isMe'];
    final String? time = message['time'];

    return Padding(
      padding: EdgeInsets.only(
        left: isMe ? 80 : 16,
        right: isMe ? 16 : 80,
        top: 10,
        bottom: time != null ? 4 : 8,
      ),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isMe ? AppTheme.primaryGreen : Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              message['text'],
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          if (time != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, right: 8),
              child: Text(
                time,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 11,
                ),
              ),
            ),
          if (!isMe && time != null)
            const Padding(
              padding: EdgeInsets.only(top: 4),
            ),
          if (isMe && message.containsKey('seen'))
            Text(
              'Seen',
              style: TextStyle(
                color: AppTheme.primaryGreen,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () => Navigator.pop(context),
        // ),
        title: Row(
          
          children: [
            
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                'https://t4.ftcdn.net/jpg/01/41/56/45/360_F_141564503_tAcki4lMMh38x9z09kgfuk4iTfV3JcX2.jpg',
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Liam Levi',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppTheme.primaryGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Online',
                      style: TextStyle(
                        color: AppTheme.primaryGreen,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          // Input Area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            color: Colors.white,
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline,
                        color: Colors.grey),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Message...',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.insert_emoticon_outlined,
                        color: Colors.grey),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 4),
                  FloatingActionButton(
                    mini: true,
                    backgroundColor: AppTheme.primaryGreen,
                    elevation: 0,
                    onPressed: () {
                      if (_controller.text.trim().isNotEmpty) {
                        setState(() {
                          _messages.add({
                            'text': _controller.text.trim(),
                            'isMe': true,
                            'seen': true,
                          });
                          _controller.clear();
                        });
                      }
                    },
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}