import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softec/providers/authentication_provider.dart';
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
