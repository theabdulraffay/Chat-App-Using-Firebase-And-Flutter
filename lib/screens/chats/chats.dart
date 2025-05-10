import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softec/configs/configs.dart';
import 'package:softec/models/chat.dart';
import 'package:softec/models/chat_message.dart';
import 'package:softec/models/chat_user.dart';
import 'package:softec/providers/authentication_provider.dart';
import 'package:softec/providers/chats_page_provider.dart';
import 'package:softec/router/routes.dart';
import 'package:softec/screens/chat/chat.dart';
import 'package:softec/widgets/custom_list_view_tiles.dart';
part 'widgets/_body.dart';
part '_state.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: _Body(),
    );
  }
}
