import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/order.dart';
import '../models/restaurant.dart';
import '../services/auth_manager.dart';
import '../services/user_preferences_manager.dart';

class ProfilePage extends StatefulWidget {
  final List<FitnessCenter> fitnessCenters;
  final List<Order> bookings;
  final AuthManager authManager;
  final UserPreferencesManager preferencesManager;
  final ThemeMode themeMode;
  final ValueChanged<bool> onThemeChanged;

  const ProfilePage({
    super.key,
    required this.fitnessCenters,
    required this.bookings,
    required this.authManager,
    required this.preferencesManager,
    required this.themeMode,
    required this.onThemeChanged,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _profileNamePromptScheduled = false;

  List<FitnessCenter> get fitnessCenters => widget.fitnessCenters;
  List<Order> get bookings => widget.bookings;
  AuthManager get authManager => widget.authManager;
  UserPreferencesManager get preferencesManager => widget.preferencesManager;
  ThemeMode get themeMode => widget.themeMode;
  ValueChanged<bool> get onThemeChanged => widget.onThemeChanged;

  @override
  void initState() {
    super.initState();
    _scheduleProfileNamePrompt();
  }

  @override
  void didUpdateWidget(ProfilePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.preferencesManager != widget.preferencesManager) {
      _profileNamePromptScheduled = false;
    }
    _scheduleProfileNamePrompt();
  }

  void _scheduleProfileNamePrompt() {
    if (_profileNamePromptScheduled ||
        !widget.preferencesManager.needsProfileName) {
      return;
    }
    _profileNamePromptScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !widget.preferencesManager.needsProfileName) {
        return;
      }
      _showEditProfileDialog(context, requireName: true);
    });
  }

  ImageProvider<Object> _buildImageProvider(String path) {
    if (path.startsWith('http')) {
      return NetworkImage(path);
    }
    return AssetImage(path);
  }

  Future<void> _showEditProfileDialog(
    BuildContext context, {
    bool requireName = false,
  }) async {
    final nameController = TextEditingController(
      text: widget.preferencesManager.profileName,
    );
    final emailController = TextEditingController(
      text: widget.preferencesManager.profileEmail,
    );
    final formKey = GlobalKey<FormState>();

    final shouldSave = await showDialog<bool>(
      context: context,
      barrierDismissible: !requireName,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(requireName ? 'Complete Your Profile' : 'Edit Profile'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: emailController,
                  readOnly: requireName,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            if (!requireName)
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('Cancel'),
              ),
            FilledButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(dialogContext, true);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (shouldSave == true) {
      await widget.preferencesManager.updateProfile(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        profileNameCompleted: requireName,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              requireName ? 'Welcome to FitZone' : 'Profile updated',
            ),
          ),
        );
      }
    }
  }

  Future<void> _showProfilePhotoSheet(BuildContext context) async {
    const presetPhotos = [
      'images/028b5f12160c4a23a9c3b6ec8e2375dc.jpg',
      'images/03b5aec90fc8a188cc55e973ac323401.jpg',
      'images/6552f06370a60a3bafe50d15f66d6587.jpg',
      'images/71c56e783f7da53daca02f592d35dc27.jpg',
      'images/8b696d542e16dca8853562c352d55438.jpg',
      'images/906a3198743a04accdc38e6a83a4d68b.jpg',
      'images/a8898449b7db9a021a187a5006e2ee43.jpg',
      'images/ace2e4eaf4ad1b3eb5d53f12009a321f.jpg',
      'images/c5b60e16a7ab446993298ffcf9cf5418.jpg',
      'images/ce3a3ed67b711a8ccbb343682e00b4a7.jpg',
      'images/e3dcd545b8b34d404217b5da7bcf9775.jpg',
    ];

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose Profile Photo',
                  style: Theme.of(
                    sheetContext,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  '${presetPhotos.length} local portraits available',
                  style: Theme.of(sheetContext).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(sheetContext).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: presetPhotos.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                        ),
                    itemBuilder: (context, index) {
                      final photoPath = presetPhotos[index];
                      final isSelected =
                          photoPath == preferencesManager.profileImageUrl;
                      return InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () async {
                          await preferencesManager.setProfileImageUrl(
                            photoPath,
                          );
                          if (sheetContext.mounted) {
                            Navigator.pop(sheetContext);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isSelected
                                  ? Theme.of(sheetContext).colorScheme.primary
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(photoPath, fit: BoxFit.cover),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showLanguageSheet(BuildContext context) async {
    const languages = ['English', 'Kazakh', 'Russian'];
    final selectedLanguage = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              for (final language in languages)
                ListTile(
                  leading: Icon(
                    language == preferencesManager.language
                        ? Icons.check_circle
                        : Icons.language,
                  ),
                  title: Text(language),
                  trailing: language == preferencesManager.language
                      ? const Icon(Icons.done)
                      : null,
                  onTap: () => Navigator.pop(sheetContext, language),
                ),
            ],
          ),
        );
      },
    );

    if (selectedLanguage != null) {
      await preferencesManager.setLanguage(selectedLanguage);
    }
  }

  Future<void> _showGoalDialog(BuildContext context) async {
    const goals = [3, 4, 5, 6, 7];
    final selectedGoal = await showDialog<int>(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          title: const Text('Weekly Goal'),
          children: [
            for (final goal in goals)
              ListTile(
                leading: Icon(
                  goal == preferencesManager.weeklyGoal
                      ? Icons.check_circle
                      : Icons.flag_outlined,
                ),
                title: Text('$goal sessions per week'),
                onTap: () => Navigator.pop(dialogContext, goal),
              ),
          ],
        );
      },
    );

    if (selectedGoal != null) {
      await preferencesManager.setWeeklyGoal(selectedGoal);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Weekly goal set to $selectedGoal sessions')),
        );
      }
    }
  }

  Future<void> _showPaymentMethods(BuildContext context) async {
    const methods = [
      'Visa ending in 4242',
      'Mastercard ending in 1908',
      'Apple Pay',
      'Cash at center',
    ];
    final selectedMethod = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              for (final method in methods)
                ListTile(
                  leading: Icon(
                    method == preferencesManager.paymentMethod
                        ? Icons.check_circle
                        : Icons.credit_card,
                  ),
                  title: Text(method),
                  onTap: () => Navigator.pop(sheetContext, method),
                ),
            ],
          ),
        );
      },
    );

    if (selectedMethod != null) {
      await preferencesManager.setPaymentMethod(selectedMethod);
    }
  }

  Future<void> _showHelpSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Help & Support',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.chat_bubble_outline),
                  title: Text('Live chat'),
                  subtitle: Text('Available daily from 9:00 to 21:00'),
                ),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.email_outlined),
                  title: Text('support@fitzone.app'),
                  subtitle: Text('Average response time: under 2 hours'),
                ),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.help_outline),
                  title: Text('FAQ'),
                  subtitle: Text(
                    'Booking changes, payment questions, and membership help',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showFavoriteCentersSheet(BuildContext context) async {
    final favorites = fitnessCenters
        .map((center) => MapEntry(center.id, center))
        .where((entry) {
          return preferencesManager.isFavorite(entry.value.name);
        })
        .toList();

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        if (favorites.isEmpty) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.favorite_border, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    'No favorite centers yet',
                    style: Theme.of(sheetContext).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Save a few centers from the discovery page to access them quickly here.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return SafeArea(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: favorites.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final entry = favorites[index];
              final center = entry.value;
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(
                    sheetContext,
                  ).colorScheme.primaryContainer,
                  child: const Icon(Icons.fitness_center),
                ),
                title: Text(center.name),
                subtitle: Text(
                  '${center.sportType} - ${center.distance.toStringAsFixed(1)} km',
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.pop(sheetContext);
                  context.go('/0/center/${entry.key}');
                },
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _showMemberPass(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Member Pass'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.qr_code_2, size: 96),
              ),
              const SizedBox(height: 16),
              Text(
                preferencesManager.profileName,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Show this code at check-in for faster access.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListenableBuilder(
      listenable: preferencesManager,
      builder: (context, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildProfileHeader(context, colorScheme, textTheme),
              const SizedBox(height: 24),
              _buildStatsRow(context, colorScheme),
              const SizedBox(height: 24),
              _buildMembershipCard(context, colorScheme, textTheme),
              const SizedBox(height: 16),
              _buildSettingsSection(context, colorScheme, textTheme),
              const SizedBox(height: 16),
              _buildAccountSection(context, colorScheme, textTheme),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: colorScheme.primaryContainer,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _buildImageProvider(
                  preferencesManager.profileImageUrl,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () => _showProfilePhotoSheet(context),
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: colorScheme.secondary,
                    shape: BoxShape.circle,
                    border: Border.all(color: colorScheme.surface, width: 2),
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 16,
                    color: colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          preferencesManager.profileName,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          preferencesManager.profileEmail,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.workspace_premium,
                size: 16,
                color: colorScheme.onTertiaryContainer,
              ),
              const SizedBox(width: 4),
              Text(
                'Premium Member',
                style: TextStyle(
                  color: colorScheme.onTertiaryContainer,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context, ColorScheme colorScheme) {
    final totalBookings = bookings.length;
    final totalSessions = bookings.fold<int>(
      0,
      (sum, order) => sum + order.totalItems,
    );

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            colorScheme,
            Icons.calendar_month,
            '$totalBookings',
            'Bookings',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            colorScheme,
            Icons.fitness_center,
            '$totalSessions',
            'Sessions',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            context,
            colorScheme,
            Icons.favorite,
            '${preferencesManager.favoriteCount}',
            'Favorites',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    ColorScheme colorScheme,
    IconData icon,
    String value,
    String label,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: colorScheme.primary, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipCard(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => _showMemberPass(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.primary, colorScheme.tertiary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'FitZone',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'PREMIUM',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Member since',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const Text(
              'January 2024',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Weekly goal',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    Text(
                      '${preferencesManager.weeklyGoal} sessions',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.qr_code_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Preferences',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: preferencesManager.notificationsEnabled
                ? 'Booking reminders & updates enabled'
                : 'Notifications are paused',
            trailing: Switch(
              value: preferencesManager.notificationsEnabled,
              onChanged: (value) {
                preferencesManager.setNotificationsEnabled(value);
              },
            ),
          ),
          _buildSettingsTile(
            context,
            icon: themeMode == ThemeMode.dark
                ? Icons.dark_mode
                : Icons.light_mode,
            title: 'Dark Mode',
            subtitle: 'Switch appearance',
            trailing: Switch(
              value: themeMode == ThemeMode.dark,
              onChanged: onThemeChanged,
            ),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.language,
            title: 'Language',
            subtitle: preferencesManager.language,
            onTap: () => _showLanguageSheet(context),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.flag_outlined,
            title: 'Fitness Goals',
            subtitle: '${preferencesManager.weeklyGoal} sessions per week',
            onTap: () => _showGoalDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Account',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.person_outline,
            title: 'Edit Profile',
            subtitle: 'Update your information',
            onTap: () => _showEditProfileDialog(context),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.credit_card_outlined,
            title: 'Payment Methods',
            subtitle: preferencesManager.paymentMethod,
            onTap: () => _showPaymentMethods(context),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.history,
            title: 'Booking History',
            subtitle: 'View past sessions',
            onTap: () => context.go('/1'),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.favorite_outline,
            title: 'Favorite Centers',
            subtitle: '${preferencesManager.favoriteCount} centers saved',
            onTap: () => _showFavoriteCentersSheet(context),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.chat_bubble_outline,
            title: 'Support Chat',
            subtitle: 'Talk with support and community',
            onTap: () => context.go('/chat'),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.help_outline,
            title: 'Help & Support',
            subtitle: 'Get assistance',
            onTap: () => _showHelpSheet(context),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.logout,
            iconColor: colorScheme.error,
            title: 'Sign Out',
            titleColor: colorScheme.error,
            subtitle: 'Log out of your account',
            onTap: () async {
              await authManager.signOut();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Color? iconColor,
    Color? titleColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (iconColor ?? colorScheme.primary).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor ?? colorScheme.primary, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500, color: titleColor),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
