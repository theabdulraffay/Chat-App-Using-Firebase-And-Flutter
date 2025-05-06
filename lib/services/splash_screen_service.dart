import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:softec/configs/configs.dart';
import 'package:softec/router/routes.dart';

class SplashScreenService {
  SplashScreenService({required this.context});
  BuildContext context;
  final instance = FirebaseAuth.instance;

  Future<void> getCurrentuser() async {
    final user = instance.currentUser;
    if (user != null) {
      AppRoutes.home.pushReplace(context);
    } else {
      AppRoutes.signup.pushReplace(context);
    }
  }
}
