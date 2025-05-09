import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text, image, unknown }

class ChatMessage {
  final String senderID;
  final String content;
  final MessageType type;
  final DateTime sentTime;

  ChatMessage({
    required this.senderID,
    required this.content,
    required this.type,
    required this.sentTime,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    final MessageType type;

    switch (json['type'] as String) {
      case 'text':
        type = MessageType.text;
        break;
      case 'image':
        type = MessageType.image;
        break;
      default:
        type = MessageType.unknown;
    }
    return ChatMessage(
      senderID: json['sender_id'] as String,
      content: json['content'] as String,
      type: type,
      sentTime: json['sent_time'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    String messageType;
    switch (type) {
      case MessageType.text:
        messageType = 'text';
        break;
      case MessageType.image:
        messageType = 'image';
        break;
      default:
        messageType = 'unknown';
    }
    return {
      'sender_id': senderID,
      'content': content,
      'type': messageType,
      'sent_time': Timestamp.fromDate(sentTime),
    };
  }
}
