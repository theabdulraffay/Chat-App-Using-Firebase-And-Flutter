import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softec/models/chat_user.dart';
import 'package:softec/providers/authentication_provider.dart';
import 'package:softec/providers/user_page_provider.dart';
import 'package:softec/widgets/custom_input_fields.dart';
import 'package:softec/widgets/custom_list_view_tiles.dart';
import 'package:softec/widgets/round_button.dart';
part 'widgets/_body.dart';
part '_state.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: _Body(),
    );
  }
}
