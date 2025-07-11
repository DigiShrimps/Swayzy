import 'package:flutter/material.dart';
import 'package:swayzy/screens/chat/widgets/message_card.dart';

import '../../constants/app_button_styles.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../l10n/app_localizations.dart';
import 'mocks/customer_messages.mocks.dart';
import 'mocks/performer_messages.mocks.dart';

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
    final localizations = AppLocalizations.of(context)!;
    final String titleText = localizations.chatTitle;

    final messages =
        currentMode == ViewMode.asCustomer
            ? customerMessages
            : performerMessages;

    return Scaffold(
      appBar: CustomAppBar(title: titleText),
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
                  child: Text(localizations.customerButton),
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
                  child: Text(localizations.performerButton),
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
