import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/restaurant.dart';
import '../services/shared_prefs_service.dart';
import '../services/user_preferences_manager.dart';
import '../widgets/restaurant_landscape_card.dart';

enum CenterSort { nearest, rating, price }

class FitnessCenterSection extends StatefulWidget {
  final List<FitnessCenter> fitnessCenters;
  final int currentTab;
  final UserPreferencesManager preferencesManager;
  final String? selectedSportType;
  final ValueChanged<String?> onSportTypeChanged;

  const FitnessCenterSection({
    super.key,
    required this.fitnessCenters,
    required this.currentTab,
    required this.preferencesManager,
    required this.selectedSportType,
    required this.onSportTypeChanged,
  });

  @override
  State<FitnessCenterSection> createState() => _FitnessCenterSectionState();
}

class _FitnessCenterSectionState extends State<FitnessCenterSection> {
  final SearchController _searchController = SearchController();
  final ScrollController _resultsScrollController = ScrollController();
  String _query = '';
  bool _openNowOnly = false;
  bool _favoritesOnly = false;
  bool _topRatedOnly = false;
  bool _nearbyOnly = false;
  CenterSort _sortBy = CenterSort.nearest;

  @override
  void initState() {
    super.initState();
    final savedQuery = SharedPrefsService.instance.lastCenterSearchText;
    _query = savedQuery;
    _searchController.text = savedQuery;
    _searchController.addListener(_handleSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_handleSearchChanged);
    _searchController.dispose();
    _resultsScrollController.dispose();
    super.dispose();
  }

  void _handleSearchChanged() {
    final value = _searchController.text.trim();
    if (value != _query) {
      setState(() {
        _query = value;
      });
      SharedPrefsService.instance.setLastCenterSearchText(value);
    }
  }

  int get _activeFilterCount {
    var count = 0;
    if (_query.isNotEmpty) count++;
    if (widget.selectedSportType != null) count++;
    if (_openNowOnly) count++;
    if (_favoritesOnly) count++;
    if (_topRatedOnly) count++;
    if (_nearbyOnly) count++;
    if (_sortBy != CenterSort.nearest) count++;
    return count;
  }

  List<String> get _sportTypes {
    final types =
        widget.fitnessCenters.map((center) => center.sportType).toSet().toList()
          ..sort();
    return types;
  }

  void _updateQuery(String value) {
    setState(() {
      _query = value.trim();
    });
    SharedPrefsService.instance.setLastCenterSearchText(_query);
  }

  void _clearFilters() {
    _searchController.clear();
    setState(() {
      _query = '';
      _openNowOnly = false;
      _favoritesOnly = false;
      _topRatedOnly = false;
      _nearbyOnly = false;
      _sortBy = CenterSort.nearest;
    });
    widget.onSportTypeChanged(null);
  }

  double _extractPrice(String value) {
    final match = RegExp(r'(\d+(?:\.\d+)?)').firstMatch(value);
    return double.tryParse(match?.group(1) ?? '') ?? double.infinity;
  }

  List<MapEntry<int, FitnessCenter>> _matchingCenters(
    Set<String> favoriteCenters,
  ) {
    final normalizedQuery = _query.toLowerCase();
    final results = widget.fitnessCenters
        .map((center) => MapEntry(center.id, center))
        .where((entry) {
          final center = entry.value;
          final matchesQuery =
              normalizedQuery.isEmpty ||
              center.name.toLowerCase().contains(normalizedQuery) ||
              center.sportType.toLowerCase().contains(normalizedQuery) ||
              center.address.toLowerCase().contains(normalizedQuery);
          final matchesSportType =
              widget.selectedSportType == null ||
              center.sportType == widget.selectedSportType;
          final matchesOpenNow = !_openNowOnly || center.isOpen;
          final matchesFavorites =
              !_favoritesOnly || favoriteCenters.contains(center.name);
          final matchesTopRated = !_topRatedOnly || center.rating >= 4.8;
          final matchesNearby = !_nearbyOnly || center.distance <= 2.0;
          return matchesQuery &&
              matchesSportType &&
              matchesOpenNow &&
              matchesFavorites &&
              matchesTopRated &&
              matchesNearby;
        }).toList();

    results.sort((a, b) {
      switch (_sortBy) {
        case CenterSort.nearest:
          return a.value.distance.compareTo(b.value.distance);
        case CenterSort.rating:
          return b.value.rating.compareTo(a.value.rating);
        case CenterSort.price:
          return _extractPrice(
            a.value.membershipPrice,
          ).compareTo(_extractPrice(b.value.membershipPrice));
      }
    });

    return results;
  }

  List<MapEntry<int, FitnessCenter>> _suggestions(String value) {
    final normalizedValue = value.toLowerCase().trim();
    if (normalizedValue.isEmpty) {
      return widget.fitnessCenters
          .map((center) => MapEntry(center.id, center))
          .take(5)
          .toList();
    }

    return widget.fitnessCenters
        .map((center) => MapEntry(center.id, center))
        .where((entry) {
          final center = entry.value;
          return center.name.toLowerCase().contains(normalizedValue) ||
              center.sportType.toLowerCase().contains(normalizedValue) ||
              center.address.toLowerCase().contains(normalizedValue);
        })
        .take(5)
        .toList();
  }

  Widget _buildSearchBar(BuildContext context) {
    return SearchAnchor.bar(
      searchController: _searchController,
      barHintText: 'Search centers, sport type, or location',
      viewHintText: 'Try "Yoga", "Downtown", or "open now"',
      suggestionsBuilder: (context, controller) {
        final suggestions = _suggestions(controller.text);
        if (suggestions.isEmpty) {
          return [
            const ListTile(
              leading: Icon(Icons.search_off),
              title: Text('No matching fitness centers'),
            ),
          ];
        }

        return suggestions.map((entry) {
          final center = entry.value;
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.fitness_center,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            title: Text(center.name),
            subtitle: Text('${center.sportType} - ${center.address}'),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_outward),
              onPressed: () {
                controller.closeView(center.name);
                context.go('/${widget.currentTab}/center/${entry.key}');
              },
            ),
            onTap: () {
              _updateQuery(center.name);
              controller.closeView(center.name);
            },
          );
        });
      },
    );
  }

  Widget _buildFilterChips() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final sportType in _sportTypes)
          FilterChip(
            label: Text(sportType),
            selected: widget.selectedSportType == sportType,
            onSelected: (selected) {
              widget.onSportTypeChanged(selected ? sportType : null);
            },
          ),
        FilterChip(
          label: const Text('Open now'),
          selected: _openNowOnly,
          onSelected: (selected) {
            setState(() {
              _openNowOnly = selected;
            });
          },
        ),
        FilterChip(
          label: const Text('Top rated'),
          selected: _topRatedOnly,
          onSelected: (selected) {
            setState(() {
              _topRatedOnly = selected;
            });
          },
        ),
        FilterChip(
          label: const Text('Within 2 km'),
          selected: _nearbyOnly,
          onSelected: (selected) {
            setState(() {
              _nearbyOnly = selected;
            });
          },
        ),
        FilterChip(
          avatar: const Icon(Icons.favorite, size: 18),
          label: const Text('Favorites'),
          selected: _favoritesOnly,
          onSelected: (selected) {
            setState(() {
              _favoritesOnly = selected;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSortControl() {
    return SegmentedButton<CenterSort>(
      segments: const [
        ButtonSegment<CenterSort>(
          value: CenterSort.nearest,
          icon: Icon(Icons.near_me_outlined),
          label: Text('Nearest'),
        ),
        ButtonSegment<CenterSort>(
          value: CenterSort.rating,
          icon: Icon(Icons.star_outline),
          label: Text('Rating'),
        ),
        ButtonSegment<CenterSort>(
          value: CenterSort.price,
          icon: Icon(Icons.sell_outlined),
          label: Text('Price'),
        ),
      ],
      selected: <CenterSort>{_sortBy},
      onSelectionChanged: (selection) {
        setState(() {
          _sortBy = selection.first;
        });
      },
    );
  }

  Widget _buildResultsSummary(int resultCount, int favoriteCount) {
    final colorScheme = Theme.of(context).colorScheme;
    final lastViewedCenterId = SharedPrefsService.instance.lastViewedCenterId;
    FitnessCenter? lastViewedCenter;
    if (lastViewedCenterId != null) {
      for (final center in widget.fitnessCenters) {
        if (center.id == lastViewedCenterId) {
          lastViewedCenter = center;
          break;
        }
      }
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.surfaceContainerHighest,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Smart Discovery',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            tooltip: 'Scroll left',
                            onPressed: () => _scrollResults(-334),
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 18,
                            ),
                          ),
                          IconButton(
                            tooltip: 'Scroll right',
                            onPressed: () => _scrollResults(334),
                            icon: const Icon(Icons.arrow_forward_ios, size: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Premium search for nearby clubs, saved places, and best-value memberships.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(
                      avatar: const Icon(Icons.place_outlined, size: 18),
                      label: Text(
                        '$resultCount match${resultCount == 1 ? '' : 'es'}',
                      ),
                    ),
                    Chip(
                      avatar: const Icon(Icons.favorite_outline, size: 18),
                      label: Text('$favoriteCount saved'),
                    ),
                    if (lastViewedCenter != null)
                      ActionChip(
                        avatar: const Icon(Icons.history, size: 18),
                        label: Text('Last viewed: ${lastViewedCenter.name}'),
                        onPressed: () {
                          context.go(
                            '/${widget.currentTab}/center/${lastViewedCenter!.id}',
                          );
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
          Badge(
            isLabelVisible: _activeFilterCount > 0,
            label: Text('$_activeFilterCount'),
            child: FilledButton.tonalIcon(
              onPressed: _activeFilterCount > 0 ? _clearFilters : null,
              icon: const Icon(Icons.restart_alt),
              label: const Text('Reset'),
            ),
          ),
        ],
      ),
    );
  }

  void _scrollResults(double offset) {
    if (!_resultsScrollController.hasClients) {
      return;
    }
    final target = (_resultsScrollController.offset + offset).clamp(
      0.0,
      _resultsScrollController.position.maxScrollExtent,
    );
    _resultsScrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  Widget _buildEmptyState() {
    return Container(
      key: const ValueKey('empty-state'),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(
            Icons.travel_explore,
            size: 56,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Text(
            'No centers match these filters',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different sport type, clear favorites, or search by another area.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _clearFilters,
            icon: const Icon(Icons.tune),
            label: const Text('Clear filters'),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(
    List<MapEntry<int, FitnessCenter>> results,
    UserPreferencesManager preferencesManager,
  ) {
    return SizedBox(
      key: ValueKey(
        'results-${results.length}-$_query-${widget.selectedSportType}-$_openNowOnly-$_favoritesOnly-$_topRatedOnly-$_nearbyOnly-${_sortBy.name}',
      ),
      height: 320,
      child: Scrollbar(
        controller: _resultsScrollController,
        thumbVisibility: true,
        trackVisibility: true,
        child: ListView.separated(
          controller: _resultsScrollController,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 2),
          itemCount: results.length,
          separatorBuilder: (context, index) => const SizedBox(width: 14),
          itemBuilder: (context, index) {
            final entry = results[index];
            return SizedBox(
              width: 320,
              child: FitnessCenterLandscapeCard(
                fitnessCenter: entry.value,
                centerId: entry.key,
                currentTab: widget.currentTab,
                isFavorite: preferencesManager.isFavorite(entry.value.name),
                onFavoriteToggle: () {
                  return preferencesManager.toggleFavorite(entry.value.name);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fitnessCenters.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return ListenableBuilder(
      listenable: widget.preferencesManager,
      builder: (context, child) {
        final results = _matchingCenters(
          widget.preferencesManager.favoriteCenters,
        );
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildResultsSummary(
                results.length,
                widget.preferencesManager.favoriteCount,
              ),
              const SizedBox(height: 16),
              _buildSearchBar(context),
              const SizedBox(height: 16),
              _buildFilterChips(),
              const SizedBox(height: 16),
              _buildSortControl(),
              const SizedBox(height: 16),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SizeTransition(sizeFactor: animation, child: child),
                  );
                },
                child: results.isEmpty
                    ? _buildEmptyState()
                    : _buildResultsList(results, widget.preferencesManager),
              ),
            ],
          ),
        );
      },
    );
  }
}
