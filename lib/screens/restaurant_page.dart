import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/restaurant.dart';
import '../models/restaurant_item.dart';
import '../models/order.dart';
import '../services/cart_manager.dart';
import '../services/orders_manager.dart';
import '../services/user_preferences_manager.dart';
import '../components/item_details.dart';
import 'checkout_page.dart';
import 'home.dart';

class FitnessCenterPage extends StatefulWidget {
  final int centerId;
  final FitnessCenter fitnessCenter;
  final CartManager cartManager;
  final OrdersManager ordersManager;
  final UserPreferencesManager preferencesManager;

  const FitnessCenterPage({
    super.key,
    required this.centerId,
    required this.fitnessCenter,
    required this.cartManager,
    required this.ordersManager,
    required this.preferencesManager,
  });

  @override
  State<FitnessCenterPage> createState() => _FitnessCenterPageState();
}

class _FitnessCenterPageState extends State<FitnessCenterPage> {
  static const double desktopThreshold = 700;
  static const double largeScreenPercentage = 0.9;
  static const double maxWidth = 1000;
  static const double drawerWidth = 375.0;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int _calculateColumnCount(double screenWidth) {
    return screenWidth > desktopThreshold ? 2 : 1;
  }

  double _calculateConstrainedWidth(double screenWidth) {
    if (screenWidth > maxWidth) {
      return maxWidth;
    }
    return screenWidth * largeScreenPercentage;
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  void _showBottomSheet(MembershipPlan item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(maxWidth: 480),
      builder: (context) {
        return ItemDetails(
          item: item,
          cartManager: widget.cartManager,
          quantityUpdated: () {
            setState(() {});
          },
        );
      },
    );
  }

  Widget _buildEndDrawer() {
    return SizedBox(
      width: drawerWidth,
      child: Drawer(
        child: CheckoutPage(
          cartManager: widget.cartManager,
          didUpdate: () {
            setState(() {});
          },
          onSubmit: (Order order) {
            widget.ordersManager.addOrder(order);
            Navigator.pop(context);
            context.go('/${FitZoneTab.bookings.value}');
          },
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return ListenableBuilder(
      listenable: widget.cartManager,
      builder: (context, child) {
        final itemCount = widget.cartManager.itemCount;
        return FloatingActionButton.extended(
          onPressed: openDrawer,
          icon: const Icon(Icons.shopping_cart),
          label: Text('$itemCount Sessions Selected'),
        );
      },
    );
  }

  Widget _buildGridItem(int index) {
    final membership = widget.fitnessCenter.memberships[index];
    return InkWell(
      onTap: () => _showBottomSheet(membership),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: membership.imageUrl.isNotEmpty
                    ? Image.network(
                        membership.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.card_membership,
                            size: 40,
                            color: Theme.of(context).colorScheme.secondary,
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      )
                    : Icon(
                        Icons.card_membership,
                        size: 40,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    membership.name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    membership.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${membership.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          membership.duration,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridView(int columns) {
    if (widget.fitnessCenter.memberships.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Text(
            'No programs available',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: widget.fitnessCenter.memberships.length,
      itemBuilder: (context, index) => _buildGridItem(index),
    );
  }

  Widget _buildGridViewSection(String title) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _buildGridView(
            _calculateColumnCount(MediaQuery.of(context).size.width),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.fitnessCenter.name,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.fitnessCenter.address,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.star, size: 20, color: Colors.amber[700]),
                const SizedBox(width: 8),
                Text(
                  '${widget.fitnessCenter.rating}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.location_on,
                  size: 20,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Text(
                  '${widget.fitnessCenter.distance} km',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  avatar: Icon(Icons.sports, size: 18),
                  label: Text(widget.fitnessCenter.sportType),
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                ),
                Chip(
                  avatar: Icon(Icons.attach_money, size: 18),
                  label: Text(widget.fitnessCenter.membershipPrice),
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                ),
                Chip(
                  avatar: Icon(Icons.schedule, size: 18),
                  label: Text(widget.fitnessCenter.openingHours),
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final constrainedWidth = _calculateConstrainedWidth(screenWidth);

    return Scaffold(
      key: scaffoldKey,
      endDrawer: _buildEndDrawer(),
      floatingActionButton: _buildFloatingActionButton(),
      body: Center(
        child: SizedBox(
          width: constrainedWidth,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 300,
                actions: [
                  ListenableBuilder(
                    listenable: widget.preferencesManager,
                    builder: (context, child) {
                      final isFavorite = widget.preferencesManager.isFavorite(
                        widget.fitnessCenter.name,
                      );
                      return IconButton(
                        tooltip: isFavorite
                            ? 'Remove from favorites'
                            : 'Save to favorites',
                        onPressed: () {
                          widget.preferencesManager.toggleFavorite(
                            widget.fitnessCenter.name,
                          );
                        },
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 220),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            key: ValueKey(isFavorite),
                            color: isFavorite ? Colors.red.shade200 : null,
                          ),
                        ),
                      );
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: 'fitness-center-${widget.centerId}',
                        child: Container(
                          color: Theme.of(
                            context,
                          ).colorScheme.secondaryContainer,
                          child: widget.fitnessCenter.imageUrl.isNotEmpty
                              ? Image.network(
                                  widget.fitnessCenter.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.fitness_center,
                                      size: 80,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    );
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value:
                                                loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                )
                              : Icon(
                                  Icons.fitness_center,
                                  size: 80,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: Icon(
                            Icons.fitness_center,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildInfoSection(),
              _buildGridViewSection('Available Programs'),
            ],
          ),
        ),
      ),
    );
  }
}
