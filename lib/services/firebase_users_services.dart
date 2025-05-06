import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseUsersServices {
  // This class is responsible for managing user data in Firebase.
  // It includes methods for creating, updating, and deleting user accounts.
  // It also handles user authentication and authorization.

  // Add your methods and properties here
  // For example:

  Future<void> createUser({
    required String email,
    required String password,
  }) async {
    // Code to create a new user in Firebase
    try {
      final userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredentials.user?.uid)
          .set({
            'id': userCredentials.user?.uid,
            'email': email,
            'password': password,
          });
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<void> loginUser(String email, String password) async {
    // Code to log in a user
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      debugPrint(
        '-------------------Error logging in user: $e--------------------',
      );
      throw Exception('Failed to log in user: $e');
    }
  }

  Future<List<TotalUsers>> getAllUsers() async {
    // Code to get all users from Firebase
    List<TotalUsers> users = [];
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('users').get();
      for (var doc in snapshot.docs) {
        users.add(TotalUsers.fromJson(doc.data()));
      }
      return users;
    } catch (e) {
      debugPrint(
        '-------------------Error getting users: $e--------------------',
      );
      throw Exception('Failed to get users: $e');
    }
  }

  Future<void> logoutUser() async {
    // Code to log out a user
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      debugPrint(
        '-------------------Error logging out user: $e--------------------',
      );
      throw Exception('Failed to log out user: $e');
    }
  }
}

class TotalUsers {
  String id;
  String email;
  String password;
  TotalUsers({required this.id, required this.email, required this.password});
  factory TotalUsers.fromJson(Map<String, dynamic> json) {
    return TotalUsers(
      id: json['id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'password': password};
  }
}
