import 'package:flutter/material.dart';
import 'package:swayzy/screens/chat/widgets/message_card.dart';

import '../../constants/app_button_styles.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import 'mocks/customer_messages.mocks.dart';
import 'mocks/performer_messages.mocks.dart';

const String _titleText = "Chat";

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

enum ViewMode { asCustomer, asPerformer }

class _ChatState extends State<Chat> {
  ViewMode currentMode = ViewMode.asCustomer;

  @override
  Widget build(BuildContext context) {
    final messages =
        currentMode == ViewMode.asCustomer
            ? customerMessages
            : performerMessages;

    return Scaffold(
      appBar: AppBar(
        title: const Text(_titleText),
        titleTextStyle: AppTextStyles.title,
        backgroundColor: AppColors.secondaryBackground,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentMode = ViewMode.asCustomer;
                    });
                  },
                  style:
                      currentMode == ViewMode.asCustomer
                          ? AppButtonStyles.selectedButton
                          : AppButtonStyles.unselectedButton,
                  child: const Text("Customer"),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentMode = ViewMode.asPerformer;
                    });
                  },
                  style:
                      currentMode == ViewMode.asPerformer
                          ? AppButtonStyles.selectedButton
                          : AppButtonStyles.unselectedButton,
                  child: const Text("Performer"),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return MessageCard(
                  photoURL: msg.photoURL,
                  userName: msg.userName,
                  orderTitle: msg.orderTitle,
                  lastMessageText: msg.lastMessageText,
                  messageTime: msg.messageTime,
                  isChecked: msg.isChecked,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
