import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:qv_patient/provider/doc_chat_notifier.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';
import 'package:qv_patient/constants/colors.dart';

class ChatScreen extends ConsumerStatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(chatProvider).initializeRecorder();
    ref.read(chatProvider).initializePlayer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    // if (mounted) {
    //   ref.read(chatProvider).dispose();
    // }
    super.dispose();
  }

  Widget _buildMessageItem(DocumentSnapshot message) {
    final chatController = ref.read(chatProvider);
    final isCurrentUser = message['sender'] ==
        'Patient'; // Change this based on the user role (Patient/Doctor)
    final messageAlignment =
        isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start;
    final messageColor = isCurrentUser ? Colors.blue[200] : Colors.grey[300];
    final borderRadius = isCurrentUser
        ? BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          );

    final decryptedText = message['text'].isNotEmpty
        ? chatController.decryptMessage(message['text'])
        : '';

    return GestureDetector(
      onLongPress: () {
        chatController.deleteMessage(message.id);
      },
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              color: messageColor,
              borderRadius: borderRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message['mediaUrl'] != null)
                  message['mediaType'] == 'image'
                      ? Image.network(message['mediaUrl'])
                      : message['mediaType'] == 'voice'
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.play_arrow),
                                  onPressed: () async {
                                    if (chatController.player != null &&
                                        chatController.player!.isOpen()) {
                                      await chatController.player!.startPlayer(
                                          fromURI: message['mediaUrl']);
                                    }
                                  },
                                ),
                                WaveWidget(
                                  config: CustomConfig(
                                    colors: [
                                      Colors.blue,
                                      Colors.blueAccent,
                                      Colors.lightBlue,
                                      Colors.lightBlueAccent,
                                    ],
                                    durations: [32000, 21000, 18000, 5000],
                                    heightPercentages: [0.35, 0.36, 0.38, 0.40],
                                    blur: MaskFilter.blur(BlurStyle.solid, 10),
                                  ),
                                  size: Size(double.infinity, 40.0),
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                if (decryptedText.isNotEmpty)
                  Text(
                    decryptedText,
                    style: TextStyle(fontSize: 16),
                  ),
                SizedBox(height: 5),
                Text(
                  message['timestamp'] != null
                      ? DateFormat('hh:mm a')
                          .format(message['timestamp'].toDate())
                      : 'Time not available',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatController = ref.read(chatProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 246),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.video_call))],
        backgroundColor: TColors.primary,
        title: Text('Doctor name'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chat')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return _buildMessageItem(message);
                  },
                );
              },
            ),
          ),
          if (chatController.isRecording)
            Container(
              color: Colors.greenAccent,
              height: 50,
              child: Center(
                child: Text(
                  'Recording...',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () {
                    chatController.pickMedia('image');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () async {
                    if (chatController.isRecording) {
                      await chatController.stopRecording();
                    } else {
                      await chatController.startRecording();
                    }
                    setState(() {});
                  },
                ),
                Expanded(
                  child: TextField(
                    style: TextStyle(color: TColors.black.withOpacity(0.5)),
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle:
                          TextStyle(color: TColors.black.withOpacity(0.5)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () async {
                        await chatController.sendMessage(_controller.text);
                        _controller.clear();
                        _scrollController.animateTo(
                          _scrollController.position.minScrollExtent,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      },
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
