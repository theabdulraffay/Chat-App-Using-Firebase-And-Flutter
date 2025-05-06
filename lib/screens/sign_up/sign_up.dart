import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softec/configs/configs.dart';
import 'package:softec/router/routes.dart';
import 'package:softec/services/firebase_users_services.dart';
part 'widgets/_body.dart';
part '_state.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: _Body(),
    );
  }
}
