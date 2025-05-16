class Message {
  final String userName;
  final String orderTitle;
  final String lastMessageText;
  final String messageTime;
  bool isChecked;
  var photoURL;

  Message({
    required this.userName,
    required this.orderTitle,
    required this.lastMessageText,
    required this.messageTime,
    required this.isChecked,
    required this.photoURL,
  });
}
