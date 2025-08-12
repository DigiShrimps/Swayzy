import 'package:flutter/material.dart';
import 'package:swayzy/global_widgets/animated_button.dart';
import 'package:swayzy/screens/chat/widgets/message_card.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../l10n/app_localizations.dart';
import 'mocks/customer_messages.mocks.dart';
import 'mocks/performer_messages.mocks.dart';
import 'models/message.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final String titleText = localizations.chatTitle;

    return Scaffold(
      appBar: CustomAppBar(title: titleText),
      body: Column(
        children: [
          AnimatedButtons<int>(
            firstLabel: localizations.customerButton,
            secondLabel: localizations.performerButton,
            currentMode: _currentPageIndex,
            leftMode: 0,
            rightMode: 1,
            onChanged: (index) {
              setState(() => _currentPageIndex = index);
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          const SizedBox(height: 5),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              children: [
                _buildMessageList(customerMessages),
                _buildMessageList(performerMessages),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(List<Message> messages) {
    return ListView.builder(
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
    );
  }
}
