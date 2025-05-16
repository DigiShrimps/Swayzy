import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import 'mocks/app_notification.mocks.dart';

const String _titleText = "Notifications";

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_titleText),
        titleTextStyle: AppTextStyles.title,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.secondaryBackground,
      ),
      body: ListView.builder(
        itemCount: appNotifications.length,
        itemBuilder: (context, index) {
          final notification = appNotifications[index];
          return GestureDetector(
            onTap: () {
              toggleReadState(
                index,
              ); // TODO перенаправлення на сторінку In Process
            },
            child: Card(
              color: AppColors.secondaryBackground,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(
                      changeReadIcon(notification.isRead),
                      color: changeReadColor(notification.isRead),
                      size: 30,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification.title,
                            style: AppTextStyles.title,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            notification.description,
                            style: AppTextStyles.body,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color changeReadColor(bool isRead) {
    return isRead ? AppColors.accent : AppColors.highlight;
  }

  IconData changeReadIcon(bool isRead) {
    return isRead
        ? Icons.mark_email_read_rounded
        : Icons.mark_email_unread_rounded;
  }

  void toggleReadState(int index) {
    return setState(() {
      appNotifications[index].isRead = !appNotifications[index].isRead;
    });
  }
}
