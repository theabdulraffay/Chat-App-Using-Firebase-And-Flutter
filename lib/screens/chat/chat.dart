import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softec/models/chat.dart';
import 'package:softec/models/chat_message.dart';
import 'package:softec/providers/authentication_provider.dart';
import 'package:softec/providers/chat_page_provider.dart';
import 'package:softec/widgets/custom_input_fields.dart';
import 'package:softec/widgets/custom_list_view_tiles.dart';
part 'widgets/_body.dart';
part '_state.dart';

class ChatScreen extends StatelessWidget {
  final Chat chat;
  const ChatScreen({super.key, required this.chat});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: _Body(chat: chat),
    );
  }
}
