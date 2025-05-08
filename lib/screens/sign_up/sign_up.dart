import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:softec/configs/configs.dart';
import 'package:softec/providers/authentication_provider.dart';
import 'package:softec/router/routes.dart';
import 'package:softec/services/database_service.dart';
import 'package:softec/services/firebase_users_services.dart';
import 'package:softec/services/media_service.dart';
import 'package:softec/widgets/custom_input_fields.dart';
import 'package:softec/widgets/round_button.dart';
import 'package:softec/widgets/rounnded_image.dart';
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
