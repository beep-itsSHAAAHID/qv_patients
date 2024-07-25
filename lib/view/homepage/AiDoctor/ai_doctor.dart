import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart'; // Your color constants
import 'package:qv_patient/constants/image_url.dart';
import 'package:qv_patient/helper/responsive.dart'; // Your image URL constants

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({
    required this.text,
    required this.isUser,
  });
}

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final apikey = "Whtasapp";
  TextEditingController messageController = TextEditingController();
  List<ChatMessage> chatMessages = [];
  bool isLoading = false;

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage(String message) async {
    if (message.trim().isEmpty) {
      print('Empty message. Nothing to send.');
      return;
    }

    setState(() {
      isLoading = true;
      chatMessages.add(ChatMessage(text: message, isUser: true));
    });

    try {
      final request = http.Request(
        'POST',
        Uri.parse("https://api.openai.com/v1/chat/completions"),
      );
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apikey',
      });
      request.body = jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            'role': 'system',
            'content':
                'You are a helpful assistant trained to provide information and advice on health and medical topics. Please focus on these areas and politely decline or suggest alternative sources for questions about non-health-related topics like mathematics.',
          },
          {
            'role': 'user',
            'content': message,
          },
        ],
        'max_tokens': 150,
      });

      final response =
          await request.send().timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseString);
        setState(() {
          chatMessages.add(ChatMessage(
            text: jsonResponse['choices'][0]['message']['content'].trim(),
            isUser: false,
          ));
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print("Request failed with status: ${response.statusCode}.");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Caught error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 252, 246),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 252, 252, 246),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("AI Doctor",
                style: TextStyle(
                    fontSize: Responsive.fontSize(context, 0.06),
                    color: TColors.black,
                    fontWeight: FontWeight.bold)),
            Text("Your Health Assistant",
                style: TextStyle(
                    fontSize: Responsive.fontSize(context, 0.03),
                    color: TColors.black,
                    fontWeight: FontWeight.normal))
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: TColors.primary.withOpacity(0.1)),
                    color: TColors.dark.withOpacity(.1)),
                child: ListView.builder(
                  itemCount: chatMessages.length,
                  itemBuilder: (ctx, index) {
                    final message = chatMessages[index];
                    return ChatBubble(
                      text: message.text,
                      isUser: message.isUser,
                    );
                  },
                ),
              ),
            ),
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: TColors.light,
                          ),
                        ),
                        prefixIcon: Icon(
                          Iconsax.message,
                          color: TColors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color: TColors.light.withOpacity(.1))),
                        fillColor: TColors.dark.withOpacity(.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: TColors.primary,
                          ),
                        ),
                        helperText: 'Enter your message...',
                        helperStyle:
                            TextStyle(color: TColors.black.withOpacity(0.5))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, left: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: TColors.primary),
                    child: IconButton(
                      color: TColors.light,
                      highlightColor: TColors.dark,
                      onPressed: () {
                        sendMessage(messageController.text);
                        messageController.clear();
                      },
                      icon: const Icon(
                        Iconsax.send_1,
                        color: TColors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatBubble({
    Key? key,
    required this.text,
    required this.isUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: FadeInSlide(
        duration: 0.9,
        child: Row(
          mainAxisAlignment:
              isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isUser)
              FadeInSlide(
                duration: 0.9,
                direction: FadeSlideDirection.ltr,
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/image/chatbot.png'), // Assuming this is defined in your constants
                ),
              ),
            SizedBox(width: 10),
            Flexible(
              child: FadeInSlide(
                duration: 0.9,
                direction: FadeSlideDirection.ltr,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isUser
                        ? TColors.primary
                        : TColors.primary
                            .withOpacity(0.2)
                            .withOpacity(.3), // Adjust based on your theme
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            if (isUser) SizedBox(width: 10),
            if (isUser)
              CircleAvatar(
                backgroundImage: AssetImage(
                    TImages.user), // Assuming this is defined in your constants
              ),
          ],
        ),
      ),
    );
  }
}
