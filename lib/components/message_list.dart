import 'package:flutter/material.dart';

import '../models/message_model.dart';
import 'message_item.dart';

class MessageList extends StatelessWidget {
  const MessageList({
    Key? key,
    required this.controller,
    required this.messages,
    required this.authorId,
  }) : super(key: key);

  final ScrollController controller;
  final List<MessageModel> messages;
  final String authorId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        controller: controller,
        reverse: true,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return MessageItem(
            message: messages[index],
            fromAuthor: messages[index].authorId == authorId,
          );
        },
      ),
    );
  }
}
