import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/message_model.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key? key,
    required this.message,
    required this.fromAuthor,
  }) : super(key: key);

  final MessageModel message;
  final bool fromAuthor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: fromAuthor ? Alignment.centerRight : Alignment.centerLeft,
      child: UnconstrainedBox(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: fromAuthor ? AppColors.message : AppColors.active,
            borderRadius: BorderRadius.only(
              topLeft: fromAuthor ? const Radius.circular(16) : Radius.zero,
              topRight: const Radius.circular(16),
              bottomLeft: const Radius.circular(16),
              bottomRight: fromAuthor ? Radius.zero : const Radius.circular(16),
            ),
          ),
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!fromAuthor)
                Text(
                  message.username,
                  style: TextStyle(
                    color: AppColors.brand,
                  ),
                ),
              if (!fromAuthor) const SizedBox(height: 5),
              Text(
                message.content,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                message.date,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
