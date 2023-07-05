import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'app_button.dart';
import 'app_input.dart';

class ChangeUsernameDialog extends StatefulWidget {
  const ChangeUsernameDialog({
    Key? key,
    required this.username,
  }) : super(key: key);

  final String username;

  @override
  State<ChangeUsernameDialog> createState() => _ChangeUserNameDnalogState();
}

class _ChangeUserNameDnalogState extends State<ChangeUsernameDialog> {
  late final TextEditingController userNameController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController()..text = widget.username;
  }

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  void saveUsername() {
    if (userNameController.text.trim().isNotEmpty) {
      Navigator.of(context).pop(userNameController.text);
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.active,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Change username to:',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              constraints: const BoxConstraints(maxWidth: 360),
              child: Row(
                children: [
                  AppInput(
                    controller: userNameController,
                    isSingleLine: true,
                  ),
                  const SizedBox(width: 8),
                  AppButton(
                    text: 'Save',
                    onTap: saveUsername,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
