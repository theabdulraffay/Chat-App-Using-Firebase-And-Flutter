import 'package:flutter/material.dart'; import 'package:provider/provider.dart';
part 'widgets/_body.dart'; part '_state.dart'; class ChatScreen extends
StatelessWidget { const ChatScreen({super.key}); @override Widget
build(BuildContext context) { return ChangeNotifierProvider<_ScreenState>(
create: (_) => _ScreenState(), child: const _Body(), ); } }
