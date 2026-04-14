import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'explore_page.dart';
import 'mybookings_page.dart';
import 'profile_page.dart';
import '../models/restaurant.dart';
import '../services/cart_manager.dart';
import '../services/orders_manager.dart';
import '../services/auth_manager.dart';
import '../services/user_preferences_manager.dart';

enum FitZoneTab { home, bookings, account }

extension FitZoneTabExtension on FitZoneTab {
  int get value {
    switch (this) {
      case FitZoneTab.home:
        return 0;
      case FitZoneTab.bookings:
        return 1;
      case FitZoneTab.account:
        return 2;
    }
  }

  static FitZoneTab fromIndex(int index) {
    switch (index) {
      case 0:
        return FitZoneTab.home;
      case 1:
        return FitZoneTab.bookings;
      case 2:
        return FitZoneTab.account;
      default:
        return FitZoneTab.home;
    }
  }
}

class Home extends StatefulWidget {
  final int tab;
  final List<FitnessCenter> fitnessCenters;
  final CartManager cartManager;
  final OrdersManager ordersManager;
  final AuthManager authManager;
  final UserPreferencesManager preferencesManager;
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;
  final ValueChanged<bool> onThemeChanged;
  final List<Color> availableColors;
  final Color currentColor;
  final ValueChanged<Color> onColorChanged;

  const Home({
    super.key,
    required this.tab,
    required this.fitnessCenters,
    required this.cartManager,
    required this.ordersManager,
    required this.authManager,
    required this.preferencesManager,
    required this.themeMode,
    required this.onToggleTheme,
    required this.onThemeChanged,
    required this.availableColors,
    required this.currentColor,
    required this.onColorChanged,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.tab;
  }

  @override
  void didUpdateWidget(Home oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tab != widget.tab) {
      _currentIndex = widget.tab;
    }
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose Theme Color'),
          content: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: widget.availableColors.map((color) {
              return GestureDetector(
                onTap: () {
                  widget.onColorChanged(color);
                  Navigator.pop(context);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: widget.currentColor == color
                        ? Border.all(color: Colors.white, width: 3)
                        : null,
                    boxShadow: widget.currentColor == color
                        ? [
                            BoxShadow(
                              color: color.withValues(alpha: 0.6),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      ExplorePage(
        currentTab: _currentIndex,
        fitnessCenters: widget.fitnessCenters,
        preferencesManager: widget.preferencesManager,
      ),
      MyBookingsPage(ordersManager: widget.ordersManager),
      ProfilePage(
        fitnessCenters: widget.fitnessCenters,
        authManager: widget.authManager,
        ordersManager: widget.ordersManager,
        preferencesManager: widget.preferencesManager,
        themeMode: widget.themeMode,
        onThemeChanged: widget.onThemeChanged,
      ),
    ];

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('FitZone'),
        actions: [
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: _showColorPicker,
            tooltip: 'Change Color',
          ),
          IconButton(
            icon: Icon(
              widget.themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: widget.onToggleTheme,
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.06),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 280),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          child: IndexedStack(
            key: ValueKey(_currentIndex),
            index: _currentIndex,
            children: screens,
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 74,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
          context.go('/$index');
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Bookings',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
