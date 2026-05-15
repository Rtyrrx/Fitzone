import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'explore_page.dart';
import 'mybookings_page.dart';
import 'profile_page.dart';
import '../models/booking_history_entry.dart';
import '../models/order.dart';
import '../services/cart_manager.dart';
import '../services/auth_manager.dart';
import '../providers/app_providers.dart';
import '../services/shared_prefs_service.dart';
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

class Home extends ConsumerStatefulWidget {
  final int tab;
  final CartManager cartManager;
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
    required this.cartManager,
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
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.tab;
    SharedPrefsService.instance.setSelectedTab(_currentIndex);
  }

  @override
  void didUpdateWidget(Home oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tab != widget.tab) {
      _currentIndex = widget.tab;
      SharedPrefsService.instance.setSelectedTab(_currentIndex);
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

  Future<void> _showJsonPreview() async {
    final jsonText = await rootBundle.loadString(
      'assets/json/fitness_centers.json',
    );
    if (!mounted) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Fitness Centers JSON'),
          content: SizedBox(
            width: 600,
            child: SingleChildScrollView(
              child: SelectableText(
                jsonText,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontFamily: 'Courier'),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final centersAsync = ref.watch(fitnessCentersProvider);
    final bookingsAsync = ref.watch(bookingsProvider);
    final bookingHistoryAsync = ref.watch(bookingHistoryProvider);
    final fitnessCenters = centersAsync.valueOrNull ?? const [];
    final bookings = bookingsAsync.valueOrNull ?? const <Order>[];
    final bookingHistory =
        bookingHistoryAsync.valueOrNull ?? const <BookingHistoryEntry>[];
    final centersError = centersAsync.hasError ? centersAsync.error : null;

    final screens = [
      if (centersError != null && fitnessCenters.isEmpty)
        _buildLoadingError(
          context,
          title: 'Unable to load fitness centers',
          message: centersError.toString(),
        )
      else
        ExplorePage(
          currentTab: _currentIndex,
          fitnessCenters: fitnessCenters,
          preferencesManager: widget.preferencesManager,
        ),
      MyBookingsPage(
        bookings: bookings,
        isLoading: bookingsAsync.isLoading,
        error: bookingsAsync.hasError ? bookingsAsync.error : null,
        bookingHistory: bookingHistory,
        isHistoryLoading: bookingHistoryAsync.isLoading,
        historyError: bookingHistoryAsync.hasError
            ? bookingHistoryAsync.error
            : null,
        showCloudHistory: ref.watch(firebaseConfiguredProvider),
        onDeleteBooking: (order) async {
          if (ref.read(firebaseConfiguredProvider) &&
              ref.read(firebaseAuthProvider).currentUserId() != null) {
            await ref.read(firebaseBookingDaoProvider).deleteBooking(order);
          }
          final bookingId = order.databaseId;
          if (bookingId == null) {
            return;
          }
          await ref.read(repositoryProvider).deleteBooking(bookingId);
        },
      ),
      ProfilePage(
        fitnessCenters: fitnessCenters,
        bookings: bookings,
        authManager: widget.authManager,
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
            icon: const Icon(Icons.data_object),
            onPressed: _showJsonPreview,
            tooltip: 'View JSON',
          ),
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
          SharedPrefsService.instance.setSelectedTab(index);
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

  Widget _buildLoadingError(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline, size: 48, color: colorScheme.error),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
