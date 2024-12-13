import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panda_test_app/app/cubits/chat/bloc.dart';
import 'package:panda_test_app/app/widgets/circular_user_avatar.dart';
import 'package:panda_test_app/app/widgets/message_bubble.dart';
import 'package:panda_test_app/core/enums/message_type_enum.dart';
import 'package:panda_test_app/core/utils/theme.dart';
import 'package:panda_test_app/gen/assets.gen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom({bool animated = true}) {
    if (_scrollController.hasClients) {
      final position = _scrollController.position.minScrollExtent;
      animated
          ? _scrollController.animateTo(
              position,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            )
          : _scrollController.jumpTo(position);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: Column(
            children: [
              _buildMessageList(),
              _buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: PandaColors.richBlack,
      surfaceTintColor: Colors.white,
      shadowColor: PandaColors.richBlack.withOpacity(0.5),
      elevation: 3,
      centerTitle: false,
      leading: CircularUserAvatar(image: Assets.images.pandaLogo.image()),
      title: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Panda',
                  style: TextStyle(fontSize: 24, color: PandaColors.richBlack)),
              Text(
                state is ChatLoaded &&
                        state.messages
                            .any((message) => message.type == MessageTypeEnum.status)
                    ? 'typing...'
                    : 'last active - recently',
                style: const TextStyle(fontSize: 14, color: PandaColors.richBlack),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMessageList() {
    return Expanded(
      child: BlocListener<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is ChatLoaded) _scrollToBottom();
        },
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChatLoaded) {
              final messages = state.messages
                  .where((message) => message.type == MessageTypeEnum.message)
                  .toList();

              if (messages.isEmpty) return const Center(child: Text('No messages yet.'));

              return ListView.builder(
                padding: const EdgeInsets.only(top: 12),
                controller: _scrollController,
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return MessageBubble(
                    message: message.data,
                    isSentByUser: message.sender == 'me',
                  );
                },
              );
            } else if (state is ChatError) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return const Center(child: Text('No messages yet.'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              textInputAction: TextInputAction.newline,
              maxLines: 3,
              minLines: 1,
              style: const TextStyle(color: PandaColors.brown),
              onSubmitted: _sendMessage,
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: PandaColors.brown),
                labelText: 'Enter message',
                contentPadding: EdgeInsets.fromLTRB(24, 24, 24, 16),
                border: PandaBorders.focusedBorder,
                focusedBorder: PandaBorders.focusedBorder,
                enabledBorder: PandaBorders.unfocusedBorder,
                disabledBorder: PandaBorders.focusedBorder,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: PandaColors.brown),
            onPressed: () => _sendMessage(messageController.text),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String message) {
    if (message.trim().isNotEmpty) {
      context.read<ChatCubit>().sendMessage(message.trim());
      messageController.clear();
    }
  }
}
