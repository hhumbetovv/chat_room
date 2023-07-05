import 'package:chat_room/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/app_screen.dart';
import 'firebase_options.dart';
import 'utils/app_cache.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppCache.instance.setUp();
  runApp(const ChatRoom());
}

class ChatRoom extends StatelessWidget {
  const ChatRoom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Chat Room',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const AppScreen(),
    );
  }
}
