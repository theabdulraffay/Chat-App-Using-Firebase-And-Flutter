import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:softec/models/chat_user.dart';
import 'package:softec/services/database_service.dart';

class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final DatabaseService _databaseService;
  late ChatUser chatUser;
  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _databaseService = GetIt.instance.get<DatabaseService>();

    _auth.authStateChanges().listen((user) {
      if (user != null) {
        _databaseService.updateUserLastSeenTime(user.uid);
        _databaseService.getUser(user.uid).then((val) {
          final data = val.data() as Map<String, dynamic>;
          chatUser = ChatUser.fromJSON({
            "uid": user.uid,
            "name": data['name'],
            "email": data['email'],
            "image": data['image'],
            "last_active": data['last_active'],
          });
        });
      }
    });
  }

  Future<void> loginUsingEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException {
      log("Error logging user into Firebase");
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> registerUserUsingEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential credentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credentials.user!.uid;
    } on FirebaseAuthException {
      log("Error registering user.");
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }
}
