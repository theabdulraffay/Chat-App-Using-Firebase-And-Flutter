import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:softec/configs/configs.dart';
import 'package:softec/router/routes.dart';
import 'package:softec/services/firebase_users_services.dart';
part 'widgets/_body.dart';
part '_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_ScreenState>(
      create: (_) => _ScreenState(),
      child: _Body(),
    );
  }
}
