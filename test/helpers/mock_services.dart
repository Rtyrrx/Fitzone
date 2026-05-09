import 'dart:async';

import 'package:chapter3/data/database/app_database.dart';
import 'package:chapter3/data/repositories/db_repository.dart';
import 'package:chapter3/models/explore_data.dart';
import 'package:chapter3/models/order.dart';
import 'package:chapter3/services/firebase_auth_service.dart';
import 'package:chapter3/services/mock_yummy_service.dart';
import 'package:drift/native.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'test_data.dart';

class FakeAuthService implements FirebaseAuthService {
  FakeAuthService({
    this.userId = 'test-user-1',
    this.email = 'student@fitzone.test',
  });

  final String userId;
  final String email;
  int loginCalls = 0;
  int signupCalls = 0;
  int logoutCalls = 0;

  @override
  Stream<User?> authStateChanges() => const Stream<User?>.empty();

  @override
  String? currentUserEmail() => email;

  @override
  String? currentUserId() => userId;

  @override
  bool isLoggedIn() => true;

  @override
  Future<void> login(String email, String password) async {
    loginCalls++;
  }

  @override
  Future<void> logout() async {
    logoutCalls++;
  }

  @override
  Future<void> signup(String email, String password) async {
    signupCalls++;
  }
}

class FakeMockFitnessService extends MockFitnessService {
  @override
  Future<ExploreData> getExploreData() async {
    final center = buildFakeFitnessCenter();
    return ExploreData(
      fitnessCenters: [center],
      categories: const [],
      friendPosts: const [],
    );
  }
}

class FakeRepository extends DBRepository {
  FakeRepository({
    AppDatabase? database,
    MockFitnessService? seedService,
  }) : super(
         database ?? AppDatabase.forTesting(NativeDatabase.memory()),
         seedService ?? FakeMockFitnessService(),
       );
}

class FakeBookingManager {
  final List<Order> _bookings = <Order>[];

  List<Order> get bookings => List.unmodifiable(_bookings);

  Future<void> add(Order order) async {
    _bookings.add(order);
  }

  Future<void> remove(Order order) async {
    _bookings.removeWhere((booking) => booking.id == order.id);
  }
}
