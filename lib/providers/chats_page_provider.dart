import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:softec/models/chat.dart';
import 'package:softec/models/chat_message.dart';
import 'package:softec/models/chat_user.dart';
import 'package:softec/providers/authentication_provider.dart';
import 'package:softec/services/database_service.dart';

class ChatsPageProvider extends ChangeNotifier {
  final AuthenticationProvider _auth;
  late DatabaseService _db;
  List<Chat> chats = [];
  late StreamSubscription _chatsStreamSubscription;

  ChatsPageProvider(this._auth) {
    _db = GetIt.instance.get<DatabaseService>();
    getChats();

    // _chatsStreamSubscription = _db.getChats().listen((event) {
    //   chats = event.docs.map((e) => Chat.fromJSON(e.data())).toList();
    //   notifyListeners();
    // });
  }

  @override
  void dispose() {
    _chatsStreamSubscription.cancel();
    super.dispose();
  }

  void getChats() async {
    try {
      var id = FirebaseAuth.instance.currentUser!.uid;
      _chatsStreamSubscription = _db.getChatsForUser(id).listen((value) async {
        print(value.docs);
        chats = await Future.wait(
          value.docs.map((val) async {
            Map<String, dynamic> chatData = val.data() as Map<String, dynamic>;

            log(chatData.toString());

            List<ChatUser> members = [];
            for (var uid in chatData['members']) {
              _db
                  .getUser(uid)
                  .then((userDoc) {
                    Map<String, dynamic> userData =
                        userDoc.data() as Map<String, dynamic>;
                    members.add(
                      ChatUser.fromJSON({
                        "uid": userDoc.id,
                        "name": userData['name'],
                        "email": userData['email'],
                        "image": userData['image'],
                        "last_active": userData['last_active'],
                      }),
                    );
                    log(members.toString());
                  })
                  .onError((e, t) {
                    log("Error getting user: $e");
                  });
            }

            List<ChatMessage> messages = [];
            QuerySnapshot lastMessage = await _db.getLastMessageForChat(val.id);

            if (lastMessage.docs.isNotEmpty) {
              messages.add(
                ChatMessage.fromJson(
                  lastMessage.docs.first.data() as Map<String, dynamic>,
                ),
              );
            }

            return Chat(
              uid: val.id,
              currentUserUid: id,
              members: members,
              messages: messages,
              activity: chatData['is_activity'],
              group: chatData['is_group'],
            );
          }).toList(),
        );
        notifyListeners();
      });
    } catch (e) {
      log("Error getting chats: $e");
    }
  }
}
