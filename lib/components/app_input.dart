import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    Key? key,
    required this.controller,
    this.isSingleLine = false,
  }) : super(key: key);

  final TextEditingController controller;
  final bool isSingleLine;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        cursorColor: Colors.white,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        maxLines: isSingleLine ? 1 : null,
        keyboardType: isSingleLine ? null : TextInputType.multiline,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.body,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
