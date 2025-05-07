import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:softec/services/database_service.dart';

class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final DatabaseService _databaseService;
  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _databaseService = GetIt.instance.get<DatabaseService>();
  }
}
