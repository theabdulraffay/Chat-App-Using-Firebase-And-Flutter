import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:softec/services/media_service.dart';
import 'package:softec/services/splash_screen_service.dart';
part 'widgets/_body.dart';
part '_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashScreenStateProvider>(
      create: (_) => SplashScreenStateProvider(),
      child: const _Body(),
    );
  }
}
