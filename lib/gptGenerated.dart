import 'package:flutter/material.dart';

class ChatGPTScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Color(0xFF1F1F1F),
        title: Text(
          'ChatGPT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListView(
                  padding: EdgeInsets.all(8.0),
                  children: [
                    _buildChatBubble(
                      'Hello! How can I assist you?',
                      true,
                    ),
                    _buildChatBubble(
                      'I have a question about Flutter.',
                      false,
                    ),
                    _buildChatBubble(
                      'Sure, I\'m here to help. What do you need?',
                      true,
                    ),
                    _buildChatBubble(
                      '...',
                      false,
                    ),
                    _buildChatBubble(
                      'Feel free to ask your question.',
                      true,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      // Send message logic
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble(String message, bool isUser) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: isUser ? Alignment.topRight : Alignment.topLeft,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isUser ? Color(0xFFDCF8C6) : Color(0xFFEAEAEA),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            message,
            style: TextStyle(
              fontSize: 16.0,
              color: isUser ? Colors.black : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}


