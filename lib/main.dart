import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'data/repositories/db_repository.dart';
import 'firebase_options.dart';
import 'providers/app_providers.dart';
import 'screens/chat_page.dart';
import 'screens/home.dart';
import 'screens/login_page.dart';
import 'screens/restaurant_page.dart';
import 'services/cart_manager.dart';
import 'services/auth_manager.dart';
import 'services/shared_prefs_service.dart';
import 'services/user_preferences_manager.dart';
import 'models/restaurant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    usePathUrlStrategy();
  }
  await SharedPrefsService.instance.ensureInitialized();
  await _initializeFirebase();
  runApp(const ProviderScope(child: FitZoneApp()));
}

Future<void> _initializeFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on UnsupportedError catch (error) {
    debugPrint(error.message);
    try {
      await Firebase.initializeApp();
    } on FirebaseException catch (fallbackError) {
      debugPrint('Firebase native initialization failed: $fallbackError');
    }
  } on FirebaseException catch (error) {
    debugPrint('Firebase initialization failed: $error');
  }
}

class FitZoneApp extends ConsumerStatefulWidget {
  const FitZoneApp({super.key});

  @override
  ConsumerState<FitZoneApp> createState() => _FitZoneAppState();
}

class _FitZoneAppState extends ConsumerState<FitZoneApp> {
  ThemeMode _themeMode = ThemeMode.light;
  Color _seedColor = Colors.blue;
  String? _lastSyncedUserId;

  final List<Color> _availableColors = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.purple,
    Colors.red,
    Colors.teal,
  ];

  late final CartManager _cartManager;
  late final AuthManager _authManager;
  late final UserPreferencesManager _userPreferencesManager;
  late final DBRepository _dbRepository;

  late final Future<void> _appInitializationFuture;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _themeMode = SharedPrefsService.instance.themeMode;
    _seedColor = SharedPrefsService.instance.seedColor;
    _cartManager = ref.read(cartManagerProvider);
    _authManager = ref.read(authManagerProvider);
    _userPreferencesManager = ref.read(userPreferencesProvider);
    _dbRepository = ref.read(repositoryProvider);
    _authManager.addListener(_handleAuthStateChanged);
    _appInitializationFuture = _initializeApp();
    _router = GoRouter(
      initialLocation: '/login',
      refreshListenable: _authManager,
      redirect: _appRedirect,
      errorPageBuilder: (context, state) {
        return MaterialPage(
          child: Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(child: Text(state.error.toString())),
          ),
        );
      },
      routes: [
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
        GoRoute(path: '/chat', builder: (context, state) => const ChatPage()),
        GoRoute(
          path: '/:tab',
          builder: (context, state) {
            final tabString = state.pathParameters['tab'] ?? '0';
            final tab = _parseTab(tabString);
            if (tab == null) {
              return _buildRouteError('Tab not found');
            }
            return Home(
              tab: tab,
              cartManager: _cartManager,
              authManager: _authManager,
              preferencesManager: _userPreferencesManager,
              themeMode: _themeMode,
              onToggleTheme: _toggleThemeMode,
              onThemeChanged: _setThemeMode,
              availableColors: _availableColors,
              currentColor: _seedColor,
              onColorChanged: _changeSeedColor,
            );
          },
          routes: [
            GoRoute(
              path: 'center/:id',
              builder: (context, state) {
                return FutureBuilder<void>(
                  future: _appInitializationFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Scaffold(
                        body: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (snapshot.hasError) {
                      return _buildRouteError('Unable to load center');
                    }

                    final tabString = state.pathParameters['tab'] ?? '0';
                    final tab = _parseTab(tabString);
                    final idString = state.pathParameters['id'] ?? '0';
                    final id = int.tryParse(idString);
                    if (tab == null || id == null || id < 0) {
                      return _buildRouteError('Center not found');
                    }

                    return Consumer(
                      builder: (context, ref, child) {
                        final centersAsync = ref.watch(fitnessCentersProvider);
                        return centersAsync.when(
                          loading: () => const Scaffold(
                            body: Center(child: CircularProgressIndicator()),
                          ),
                          error: (error, stackTrace) =>
                              _buildRouteError('Unable to load center'),
                          data: (centers) {
                            FitnessCenter? fitnessCenter;
                            for (final center in centers) {
                              if (center.id == id) {
                                fitnessCenter = center;
                                break;
                              }
                            }

                            if (fitnessCenter == null) {
                              return _buildRouteError('Center not found');
                            }

                            return FitnessCenterPage(
                              centerId: id,
                              fitnessCenter: fitnessCenter,
                              cartManager: _cartManager,
                              preferencesManager: _userPreferencesManager,
                              onSubmitBooking: (order) async {
                                final userId =
                                    FirebaseAuth.instance.currentUser?.uid ??
                                    SharedPrefsService.instance.activeUserId;
                                final booking = order.copyWith(userId: userId);
                                await ref
                                    .read(repositoryProvider)
                                    .saveBooking(booking);
                                if (ref.read(firebaseConfiguredProvider) &&
                                    FirebaseAuth.instance.currentUser != null) {
                                  await ref
                                      .read(firebaseBookingDaoProvider)
                                      .saveBooking(booking);
                                }
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _initializeApp() async {
    await SharedPrefsService.instance.ensureInitialized();
    await _authManager.init();
    await _syncCurrentUserState(force: true);
    await _dbRepository.init();
  }

  void _handleAuthStateChanged() {
    unawaited(_syncCurrentUserState());
  }

  Future<void> _syncCurrentUserState({bool force = false}) async {
    final user = Firebase.apps.isEmpty ? null : FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? SharedPrefsService.instance.activeUserId;
    if (!force && _lastSyncedUserId == userId) {
      return;
    }
    _lastSyncedUserId = userId;
    await SharedPrefsService.instance.setActiveUserId(userId);
    await _dbRepository.setCurrentUserId(userId);
    await _userPreferencesManager.switchUser(userId, email: user?.email);
    if (mounted) {
      setState(() {
        _themeMode = SharedPrefsService.instance.themeMode;
        _seedColor = SharedPrefsService.instance.seedColor;
      });
    }
  }

  Future<String?> _appRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    final isLoggedIn = _authManager.isLoggedIn;
    final isLoggingIn = state.matchedLocation == '/login';
    final requestedLocation = state.uri.toString();
    final from = state.uri.queryParameters['from'];

    if (!isLoggedIn && !isLoggingIn) {
      return Uri(
        path: '/login',
        queryParameters: {'from': requestedLocation},
      ).toString();
    }

    if (isLoggedIn && isLoggingIn) {
      if (from != null && from.isNotEmpty && from != '/login') {
        return from;
      }
      return '/${SharedPrefsService.instance.selectedTab}';
    }

    return null;
  }

  int? _parseTab(String tabString) {
    final tab = int.tryParse(tabString);
    if (tab == null || tab < 0 || tab > FitZoneTab.account.value) {
      return null;
    }
    return tab;
  }

  Widget _buildRouteError(String message) {
    return Scaffold(body: Center(child: Text(message)));
  }

  void _toggleThemeMode() {
    final nextMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    setState(() {
      _themeMode = nextMode;
    });
    SharedPrefsService.instance.setThemeMode(nextMode);
  }

  void _setThemeMode(bool isDark) {
    final nextMode = isDark ? ThemeMode.dark : ThemeMode.light;
    setState(() {
      _themeMode = nextMode;
    });
    SharedPrefsService.instance.setThemeMode(nextMode);
  }

  void _changeSeedColor(Color color) {
    setState(() {
      _seedColor = color;
    });
    SharedPrefsService.instance.setSeedColor(color);
  }

  @override
  void dispose() {
    _authManager.removeListener(_handleAuthStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lightScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    );
    final darkScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    );

    return MaterialApp.router(
      title: 'FitZone',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: lightScheme,
        useMaterial3: true,
        scaffoldBackgroundColor: lightScheme.surface,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: lightScheme.surface.withValues(alpha: 0.92),
          foregroundColor: lightScheme.onSurface,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: lightScheme.surface.withValues(alpha: 0.96),
          indicatorColor: lightScheme.primaryContainer,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            return TextStyle(
              fontWeight: states.contains(WidgetState.selected)
                  ? FontWeight.w700
                  : FontWeight.w500,
            );
          }),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: lightScheme.surfaceContainerHighest.withValues(alpha: 0.6),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: lightScheme.outlineVariant),
          ),
        ),
        chipTheme: ChipThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          margin: const EdgeInsets.all(8),
          color: lightScheme.surface.withValues(alpha: 0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: darkScheme,
        useMaterial3: true,
        scaffoldBackgroundColor: darkScheme.surface,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: darkScheme.surface.withValues(alpha: 0.92),
          foregroundColor: darkScheme.onSurface,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: darkScheme.surface.withValues(alpha: 0.96),
          indicatorColor: darkScheme.primaryContainer,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            return TextStyle(
              fontWeight: states.contains(WidgetState.selected)
                  ? FontWeight.w700
                  : FontWeight.w500,
            );
          }),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: darkScheme.surfaceContainerHighest.withValues(alpha: 0.45),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: darkScheme.outlineVariant),
          ),
        ),
        chipTheme: ChipThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          margin: const EdgeInsets.all(8),
          color: darkScheme.surface.withValues(alpha: 0.88),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }
}
