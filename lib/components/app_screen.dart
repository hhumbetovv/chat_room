import 'package:chat_room/components/change_username_dialog.dart';
import 'package:chat_room/components/scroll_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../constants/app_colors.dart';
import '../enums/cache_items.dart';
import '../models/message_model.dart';
import 'app_bottom_sheet.dart';
import 'message_list.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  String username = CacheItems.username.getString;
  String authorId = CacheItems.authorId.getString;
  late final ScrollController scrollController;
  ValueNotifier<bool> showFabButton = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void initialize() async {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >= 500) {
        showFabButton.value = true;
      } else {
        showFabButton.value = false;
      }
    });
    if (username.isEmpty) {
      username = 'Guest';
      await CacheItems.username.setString(username);
    }
    if (authorId.isEmpty) {
      authorId = const Uuid().v4();
      await CacheItems.authorId.setString(authorId);
    }
  }

  void changeUsername() async {
    final String? response = await showDialog<String?>(
      context: context,
      builder: (context) {
        return ChangeUsernameDialog(
          username: username,
        );
      },
    );
    if (response != null) {
      setState(() {
        username = response;
      });
      await CacheItems.username.setString(username);
    }
  }

  void scrollToEnd() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: changeUsername,
            icon: const Icon(Icons.edit),
          )
        ],
        title: const Text('Chat Room'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('messages').orderBy('timeStamp', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                      style: TextStyle(color: AppColors.message),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  List<DocumentSnapshot> documents = snapshot.data!.docs;
                  List<MessageModel> messages = documents.map((document) {
                    return MessageModel.fromJson(document.data() as Map<String, dynamic>);
                  }).toList();
                  if (scrollController.hasClients && scrollController.offset < 500) scrollToEnd();
                  return Stack(
                    children: [
                      MessageList(
                        messages: messages,
                        controller: scrollController,
                        authorId: authorId,
                      ),
                      ScrollButton(
                        showFabButton: showFabButton,
                        onTap: scrollToEnd,
                      ),
                    ],
                  );
                }
                return const LinearProgressIndicator();
              },
            ),
          ),
          AppBottomSheet(
            authorId: authorId,
            username: username,
          )
        ],
      ),
    );
  }
}
