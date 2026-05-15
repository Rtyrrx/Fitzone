import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/booking_history_entry.dart';
import '../models/order.dart';

class MyBookingsPage extends StatelessWidget {
  final List<Order> bookings;
  final bool isLoading;
  final Object? error;
  final List<BookingHistoryEntry> bookingHistory;
  final bool isHistoryLoading;
  final Object? historyError;
  final bool showCloudHistory;
  final Future<void> Function(Order order) onDeleteBooking;

  const MyBookingsPage({
    super.key,
    required this.bookings,
    required this.isLoading,
    required this.error,
    this.bookingHistory = const [],
    this.isHistoryLoading = false,
    this.historyError,
    this.showCloudHistory = false,
    required this.onDeleteBooking,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && bookings.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (error != null && bookings.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('My Bookings')),
        body: Center(child: Text('Unable to load bookings')),
      );
    }

    final content = <Widget>[];
    if (showCloudHistory) {
      content.add(
        _CloudHistorySection(
          entries: bookingHistory,
          isLoading: isHistoryLoading,
          error: historyError,
        ),
      );
      content.add(const SizedBox(height: 12));
    }

    if (bookings.isEmpty) {
      content.add(const _EmptyBookingsState());
    } else {
      content.add(
        Text(
          'Active Bookings',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      );
      content.add(const SizedBox(height: 8));
      content.addAll(
        bookings.map(
          (order) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _BookingTile(
              order: order,
              onDelete: () => onDeleteBooking(order),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      body: ListView(padding: const EdgeInsets.all(12), children: content),
    );
  }
}

class _EmptyBookingsState extends StatelessWidget {
  const _EmptyBookingsState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No bookings yet',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Book a session at a fitness center',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _CloudHistorySection extends StatelessWidget {
  final List<BookingHistoryEntry> entries;
  final bool isLoading;
  final Object? error;

  const _CloudHistorySection({
    required this.entries,
    required this.isLoading,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.cloud_done_outlined, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Firebase Booking History',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Cloud log of who booked what, quantity, exact time, and total price.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            if (isLoading && entries.isEmpty)
              const Center(child: CircularProgressIndicator())
            else if (error != null && entries.isEmpty)
              const Text('Unable to load Firebase booking history')
            else if (entries.isEmpty)
              const Text('No Firebase booking history yet')
            else
              ...entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _HistoryTile(entry: entry),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final BookingHistoryEntry entry;

  const _HistoryTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: entry.isCancellation
                      ? colorScheme.errorContainer
                      : colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  entry.eventLabel,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: entry.isCancellation
                        ? colorScheme.onErrorContainer
                        : colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                dateFormat.format(entry.eventAt.toLocal()),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            entry.itemSummary,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text('Member: ${entry.memberName}'),
          if (entry.userEmail.isNotEmpty) Text('Account: ${entry.userEmail}'),
          Text('Quantity: ${entry.itemCount}'),
          Text('Total: \$${entry.totalPrice.toStringAsFixed(2)}'),
          if (entry.scheduledDate != null || entry.scheduledTime != null) ...[
            const SizedBox(height: 4),
            Text(
              'Scheduled for: '
              '${entry.scheduledDate != null ? DateFormat('MMM dd, yyyy').format(entry.scheduledDate!) : 'Any day'}'
              '${entry.scheduledTime != null ? ' at ${entry.scheduledTime}' : ''}',
            ),
          ],
        ],
      ),
    );
  }
}

class _BookingTile extends StatelessWidget {
  final Order order;
  final Future<void> Function() onDelete;

  const _BookingTile({required this.order, required this.onDelete});

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: const Text('Are you sure you want to cancel this booking?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              await onDelete();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: order.type == BookingType.scheduled
                        ? colorScheme.primaryContainer
                        : colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    order.statusText,
                    style: TextStyle(
                      color: order.type == BookingType.scheduled
                          ? colorScheme.onPrimaryContainer
                          : colorScheme.onSecondaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      dateFormat.format(order.createdAt),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () => _showDeleteConfirmation(context),
                      icon: Icon(
                        Icons.delete_outline,
                        color: colorScheme.error,
                        size: 20,
                      ),
                      tooltip: 'Cancel booking',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Member: ${order.memberName}',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            if (order.scheduledDate != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    dateFormat.format(order.scheduledDate!),
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                  if (order.scheduledTime != null) ...[
                    const SizedBox(width: 16),
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      order.scheduledTime!,
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                  ],
                ],
              ),
            ],
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            ...order.items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${item.item.name} x${item.quantity}'),
                    Text('\$${item.totalPrice.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${order.totalItems} session(s)',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  'Total: \$${order.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
