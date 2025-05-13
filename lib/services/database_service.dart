import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:softec/models/chat_message.dart';

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

  Future<QuerySnapshot> getUsers({String? name}) {
    Query _query = _db.collection(USER_COLLECTION);
    if (name != null) {
      _query = _query
          .where("name", isGreaterThanOrEqualTo: name)
          .where("name", isLessThanOrEqualTo: name + "z");
    }
    return _query.get();
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

  // /==============
  Stream<QuerySnapshot> streamMessagesForChat(String _chatID) {
    return _db
        .collection(CHAT_COLLECTION)
        .doc(_chatID)
        .collection(MESSAGES_COLLECTION)
        .orderBy("sent_time", descending: false)
        .snapshots();
  }

  Future<void> addMessageToChat(String _chatID, ChatMessage _message) async {
    try {
      await _db
          .collection(CHAT_COLLECTION)
          .doc(_chatID)
          .collection(MESSAGES_COLLECTION)
          .add(_message.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateChatData(String chatID, Map<String, dynamic> data) async {
    try {
      await _db.collection(CHAT_COLLECTION).doc(chatID).update(data);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteChat(String _chatID) async {
    try {
      await _db.collection(CHAT_COLLECTION).doc(_chatID).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<DocumentReference?> createChat(Map<String, dynamic> _data) async {
    try {
      DocumentReference _chat = await _db
          .collection(CHAT_COLLECTION)
          .add(_data);
      return _chat;
    } catch (e) {
      print(e);
    }
  }
}
