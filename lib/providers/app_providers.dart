import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/app_database.dart';
import '../data/firebase/booking_dao.dart';
import '../data/firebase/message_dao.dart';
import '../data/repositories/db_repository.dart';
import '../models/chat_message.dart';
import '../models/order.dart';
import '../models/restaurant.dart';
import '../services/auth_manager.dart';
import '../services/cart_manager.dart';
import '../services/firebase_auth_service.dart';
import '../services/mock_yummy_service.dart';
import '../services/user_preferences_manager.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final seedServiceProvider = Provider<MockFitnessService>((ref) {
  return MockFitnessService();
});

final dbRepositoryProvider = Provider<DBRepository>((ref) {
  return DBRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(seedServiceProvider),
  );
});

final repositoryProvider = Provider<DBRepository>((ref) {
  return ref.watch(dbRepositoryProvider);
});

final fitnessCentersProvider = StreamProvider<List<FitnessCenter>>((ref) {
  return ref.watch(repositoryProvider).watchCenters();
});

final bookingsProvider = StreamProvider<List<Order>>((ref) async* {
  final authState = ref.watch(firebaseAuthStateProvider);
  final user = authState.valueOrNull;
  final userId = user?.uid ?? 'local-user';
  final repository = ref.watch(repositoryProvider);
  await repository.setCurrentUserId(userId);
  if (ref.watch(firebaseConfiguredProvider) && user != null) {
    yield* ref.watch(firebaseBookingDaoProvider).watchBookings();
    return;
  }
  yield* repository.watchBookings();
});

final cartManagerProvider = Provider<CartManager>((ref) {
  return CartManager();
});

final authManagerProvider = Provider<AuthManager>((ref) {
  return AuthManager();
});

final userPreferencesProvider = Provider<UserPreferencesManager>((ref) {
  return UserPreferencesManager();
});

final firebaseConfiguredProvider = Provider<bool>((ref) {
  return Firebase.apps.isNotEmpty;
});

final firebaseAuthProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService(FirebaseAuth.instance);
});

final firebaseAuthStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final chatMessageDaoProvider = Provider<MessageDao>((ref) {
  return MessageDao(
    FirebaseFirestore.instance,
    ref.watch(firebaseAuthProvider),
  );
});

final firebaseBookingDaoProvider = Provider<FirebaseBookingDao>((ref) {
  return FirebaseBookingDao(
    FirebaseFirestore.instance,
    ref.watch(firebaseAuthProvider),
  );
});

final chatMessagesProvider = StreamProvider<List<ChatMessage>>((ref) {
  if (!ref.watch(firebaseConfiguredProvider)) {
    return const Stream<List<ChatMessage>>.empty();
  }
  return ref.watch(chatMessageDaoProvider).watchMessages();
});
