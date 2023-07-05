import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class ScrollButton extends StatelessWidget {
  const ScrollButton({
    Key? key,
    required this.showFabButton,
    this.onTap,
  }) : super(key: key);

  final ValueNotifier<bool> showFabButton;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: showFabButton,
      builder: (context, showButton, child) {
        if (showButton) {
          return Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton.small(
              backgroundColor: AppColors.body,
              onPressed: onTap,
              child: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.message,
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
