import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/chat_message.dart';
import '../../services/firebase_auth_service.dart';

class MessageDao {
  MessageDao(this._firestore, this._authService);

  final FirebaseFirestore _firestore;
  final FirebaseAuthService _authService;

  CollectionReference<Map<String, dynamic>> get _messages =>
      _firestore.collection('fitness_messages');

  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      throw Exception('Message cannot be empty.');
    }
    final userId = _authService.currentUserId();
    final email = _authService.currentUserEmail();
    if (userId == null || email == null) {
      throw Exception('Log in to send messages.');
    }

    await _messages.add({
      'text': trimmed,
      'email': email,
      'userId': userId,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<ChatMessage>> watchMessages() {
    return _messages
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map(ChatMessage.fromSnapshot).toList(),
        );
  }
}
