import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

const String USER_COLLECTION = 'Users';
const String CHAT_COLLECTION = 'Chats';
const String MESSAGES_COLLECTION = 'messages';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  DatabaseService() {
    // Initialize the database service if needed
  }

  Future<DocumentSnapshot> getUser(String uid) async {
    return await _db.collection(USER_COLLECTION).doc(uid).get();
  }

  Future<void> updateUserLastSeenTime(String uis) async {
    try {
      await _db.collection(USER_COLLECTION).doc(uis).update({
        'last_active': DateTime.now().toUtc(),
      });
    } catch (e) {
      log("Error updating last seen time: $e");
    }
  }

  Future<void> createUser({
    String? uid,
    String? email,
    String? image,
    String? name,
  }) async {
    try {
      await _db.collection(USER_COLLECTION).doc(uid).set({
        'email': email,
        'image': image,
        'name': name,
        'last_active': DateTime.now(),
      });
    } catch (e) {
      log("Error updating last seen time: $e");
    }
  }

  // This function will retrieve chats from the database
  Stream<QuerySnapshot> getChatsForUser(String uid) {
    return _db
        .collection(CHAT_COLLECTION)
        .where('members', arrayContains: uid)
        .snapshots();
  }

  // This function will retrieve last messages from the database
  Future<QuerySnapshot> getLastMessageForChat(String id) {
    return _db
        .collection(CHAT_COLLECTION)
        .doc(id)
        .collection(MESSAGES_COLLECTION)
        .orderBy('sent_time', descending: true)
        .limit(1)
        .get();
  }
}
