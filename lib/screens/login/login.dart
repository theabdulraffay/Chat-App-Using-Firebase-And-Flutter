import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softec/configs/configs.dart';
import 'package:softec/providers/authentication_provider.dart';
import 'package:softec/router/routes.dart';
import 'package:softec/widgets/custom_input_fields.dart';
import 'package:softec/widgets/round_button.dart';
part 'widgets/_body.dart';
part '_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: _Body(),
    );
  }
}
