import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../constants/app_colors.dart';
import '../models/message_model.dart';
import 'app_input.dart';

class AppBottomSheet extends StatefulWidget {
  const AppBottomSheet({
    Key? key,
    required this.username,
    required this.authorId,
  }) : super(key: key);

  final String username;
  final String authorId;

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  late final TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() async {
    DateTime currentDate = DateTime.now();
    final MessageModel message = MessageModel(
      id: const Uuid().v1(),
      date: DateFormat('HH:mm').format(currentDate),
      content: messageController.text.trim(),
      authorId: widget.authorId,
      username: widget.username,
    );
    debugPrint(widget.username);
    messageController.clear();
    await FirebaseFirestore.instance.collection('messages').doc(message.id).set(
      {...message.toJson(), 'timeStamp': Timestamp.fromDate(currentDate)},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            AppInput(
              controller: messageController,
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(CupertinoIcons.paperplane_fill),
              color: AppColors.brand,
              onPressed: sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
