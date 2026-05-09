import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  ChatMessage({
    required this.id,
    required this.text,
    required this.email,
    required this.userId,
    required this.createdAt,
  });

  final String id;
  final String text;
  final String email;
  final String userId;
  final DateTime createdAt;

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    final createdAtValue = json['createdAt'];
    return ChatMessage(
      id: json['id'] as String? ?? '',
      text: json['text'] as String? ?? '',
      email: json['email'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      createdAt: createdAtValue is Timestamp
          ? createdAtValue.toDate()
          : createdAtValue is String
          ? DateTime.tryParse(createdAtValue) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  factory ChatMessage.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return ChatMessage.fromJson({'id': doc.id, ...data});
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'email': email,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
