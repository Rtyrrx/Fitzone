import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'screens/home.dart';
import 'screens/login_page.dart';
import 'screens/restaurant_page.dart';
import 'services/cart_manager.dart';
import 'services/orders_manager.dart';
import 'services/auth_manager.dart';
import 'services/mock_yummy_service.dart';
import 'services/user_preferences_manager.dart';
import 'models/restaurant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(const FitZoneApp());
}

class FitZoneApp extends StatefulWidget {
  const FitZoneApp({super.key});

  @override
  State<FitZoneApp> createState() => _FitZoneAppState();
}

class _FitZoneAppState extends State<FitZoneApp> {
  ThemeMode _themeMode = ThemeMode.light;
  Color _seedColor = Colors.blue;

  final List<Color> _availableColors = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.purple,
    Colors.red,
    Colors.teal,
  ];

  final CartManager _cartManager = CartManager();
  final OrdersManager _ordersManager = OrdersManager();
  final AuthManager _authManager = AuthManager();
  final UserPreferencesManager _userPreferencesManager =
      UserPreferencesManager();
  List<FitnessCenter> _fitnessCenters = [];

  late final Future<void> _appInitializationFuture;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
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
        GoRoute(
          path: '/login',
          builder: (context, state) => LoginPage(
            onLogin: () async {
              await _authManager.signIn();
            },
          ),
        ),
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
              fitnessCenters: _fitnessCenters,
              cartManager: _cartManager,
              ordersManager: _ordersManager,
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

                    final fitnessCenter = id < _fitnessCenters.length
                        ? _fitnessCenters[id]
                        : null;
                    if (fitnessCenter == null) {
                      return _buildRouteError('Center not found');
                    }

                    return FitnessCenterPage(
                      centerId: id,
                      fitnessCenter: fitnessCenter,
                      cartManager: _cartManager,
                      ordersManager: _ordersManager,
                      preferencesManager: _userPreferencesManager,
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
    await _authManager.init();
    await _ordersManager.init();
    await _userPreferencesManager.init();
    final service = MockFitnessService();
    final data = await service.getExploreData();
    setState(() {
      _fitnessCenters = data.fitnessCenters;
    });
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
      return '/${FitZoneTab.home.value}';
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
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  void _setThemeMode(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _changeSeedColor(Color color) {
    setState(() {
      _seedColor = color;
    });
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
