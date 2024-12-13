import 'package:flutter/material.dart';
import 'package:panda_test_app/core/utils/theme.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isSentByUser;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isSentByUser,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: EdgeInsets.only(
          top: 6,
          bottom: 6,
          right: isSentByUser ? 12 : 36,
          left: isSentByUser ? 36 : 12,
        ),
        decoration: BoxDecoration(
          color: isSentByUser ? PandaColors.pinkAccent : PandaColors.pink,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isSentByUser ? const Radius.circular(12) : Radius.zero,
            bottomRight: isSentByUser ? Radius.zero : const Radius.circular(12),
          ),
        ),
        child: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
            color: PandaColors.richBlack,
          ),
        ),
      ),
    );
  }
}
