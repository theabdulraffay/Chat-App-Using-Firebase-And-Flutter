import 'dart:async';
import 'dart:developer';

//Packages
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:softec/services/upload_image_service.dart';

//Services
import '../services/database_service.dart';
import '../services/cloud_storage_service.dart';
import '../services/media_service.dart';

//Providers
import '../providers/authentication_provider.dart';

//Models
import '../models/chat_message.dart';

class ChatPageProvider extends ChangeNotifier {
  late DatabaseService _db;
  late CloudStorageService _storage;
  late MediaService _media;

  AuthenticationProvider _auth;
  ScrollController _messagesListViewController;

  String _chatId;
  List<ChatMessage> messages = [];

  late StreamSubscription _messagesStream;
  late StreamSubscription _keyboardVisibilityStream;
  late KeyboardVisibilityController _keyboardVisibilityController;

  String? _message;

  String get message {
    return message;
  }

  set message(String value) {
    _message = value;
  }

  ChatPageProvider(this._chatId, this._auth, this._messagesListViewController) {
    _db = GetIt.instance.get<DatabaseService>();
    _storage = GetIt.instance.get<CloudStorageService>();
    _media = GetIt.instance.get<MediaService>();
    _keyboardVisibilityController = KeyboardVisibilityController();
    listenToMessages();
    listenToKeyboardChanges();
  }

  @override
  void dispose() {
    _messagesStream.cancel();
    super.dispose();
  }

  void listenToMessages() {
    try {
      _messagesStream = _db.streamMessagesForChat(_chatId).listen((snapshot) {
        List<ChatMessage> messages2 =
            snapshot.docs.map((m) {
              Map<String, dynamic> messageData =
                  m.data() as Map<String, dynamic>;
              return ChatMessage.fromJson(messageData);
            }).toList();
        messages = messages2;
        notifyListeners();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_messagesListViewController.hasClients) {
            _messagesListViewController.jumpTo(
              _messagesListViewController.position.maxScrollExtent,
            );
          }
        });
      });
    } catch (e) {
      log("Error getting messages.");
      log(e.toString());
    }
  }

  void listenToKeyboardChanges() {
    _keyboardVisibilityStream = _keyboardVisibilityController.onChange.listen((
      event,
    ) {
      _db.updateChatData(_chatId, {"is_activity": event});
    });
  }

  void sendTextMessage() {
    if (_message != null) {
      ChatMessage messageToSend = ChatMessage(
        content: _message!,
        type: MessageType.text,
        senderID: _auth.chatUser.uid,
        sentTime: DateTime.now(),
      );
      _db.addMessageToChat(_chatId, messageToSend);
    }
  }

  void sendImageMessage() async {
    try {
      PlatformFile? file = await _media.pickImageFromLibrary();
      if (file != null) {
        String? downloadURL = await GetIt.instance
            .get<UploadImageService>()
            .uploadImage(file.path!);
        ChatMessage messageToSend = ChatMessage(
          content: downloadURL ?? '',
          type: MessageType.image,
          senderID: _auth.chatUser.uid,
          sentTime: DateTime.now(),
        );
        _db.addMessageToChat(_chatId, messageToSend);
      }
    } catch (e) {
      log("Error sending image message.");
      log(e.toString());
    }
  }

  void deleteChat() {
    goBack();
    _db.deleteChat(_chatId);
  }

  void goBack() {
    // _navigation.goBack();
  }
}
