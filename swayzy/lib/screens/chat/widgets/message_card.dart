import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';

class MessageCard extends StatelessWidget {
  final String? photoURL;
  final String userName;
  final String orderTitle;
  final String lastMessageText;
  final String messageTime;
  final bool isChecked;

  const MessageCard({
    super.key,
    required this.photoURL,
    required this.userName,
    required this.orderTitle,
    required this.lastMessageText,
    required this.messageTime,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondaryBackground,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage:
                  photoURL != null ? NetworkImage(photoURL!) : null,
              child:
                  photoURL == null
                      ? const Icon(Icons.account_circle_rounded, size: 40)
                      : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(userName, style: AppTextStyles.smallDescription),
                      Text(messageTime, style: AppTextStyles.smallDescription),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(orderTitle, style: AppTextStyles.form, maxLines: 1),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          lastMessageText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: AppTextStyles.smallDescription,
                        ),
                      ),
                      isChecked
                          ? Icon(
                            Icons.done,
                            size: 20,
                            color: AppColors.highlight,
                          )
                          : Icon(
                            Icons.done_all,
                            size: 20,
                            color: AppColors.accent,
                          ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
