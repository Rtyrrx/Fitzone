import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/order.dart';
import '../services/cart_manager.dart';

class CheckoutPage extends StatefulWidget {
  final CartManager cartManager;
  final VoidCallback didUpdate;
  final void Function(Order) onSubmit;

  const CheckoutPage({
    super.key,
    required this.cartManager,
    required this.didUpdate,
    required this.onSubmit,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final Map<int, Widget> _bookingTypes = const {
    0: Text('In Person'),
    1: Text('Schedule'),
  };

  Set<int> _selectedSegment = {0};
  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;
  final DateTime _firstDate = DateTime.now();
  final DateTime _lastDate = DateTime.now().add(const Duration(days: 365));
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onSegmentSelected(Set<int> segmentIndex) {
    setState(() {
      _selectedSegment = segmentIndex;
    });
  }

  Widget _buildBookingSegmentedType() {
    return SegmentedButton<int>(
      segments: _bookingTypes.entries.map((entry) {
        return ButtonSegment<int>(value: entry.key, label: entry.value);
      }).toList(),
      selected: _selectedSegment,
      onSelectionChanged: _onSegmentSelected,
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Member Name',
        hintText: 'Enter your name',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person),
      ),
    );
  }

  String _formatDate(DateTime? dateTime) {
    if (dateTime == null) return 'Select Date';
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: _firstDate,
      lastDate: _lastDate,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatTimeOfDay(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) return 'Select Time';
    final hour = timeOfDay.hourOfPeriod == 0 ? 12 : timeOfDay.hourOfPeriod;
    final minute = timeOfDay.minute.toString().padLeft(2, '0');
    final period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Widget _buildDateTimePickers() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _selectDate(context),
            icon: const Icon(Icons.calendar_today),
            label: Text(_formatDate(_selectedDate)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _selectTime(context),
            icon: const Icon(Icons.access_time),
            label: Text(_formatTimeOfDay(_selectedTime)),
          ),
        ),
      ],
    );
  }

  Widget _buildBookingSummary(BuildContext context) {
    final items = widget.cartManager.items;

    if (items.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text('No sessions selected'),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Dismissible(
          key: Key(item.id),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            widget.cartManager.removeItem(item.id);
            widget.didUpdate();
            setState(() {});
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: item.item.imageUrl.isNotEmpty
                  ? Image.network(
                      item.item.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 50,
                          height: 50,
                          color: Theme.of(
                            context,
                          ).colorScheme.secondaryContainer,
                          child: Icon(
                            Icons.fitness_center,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        );
                      },
                    )
                  : Container(
                      width: 50,
                      height: 50,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: Icon(
                        Icons.fitness_center,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
            ),
            title: Text(item.item.name),
            subtitle: Text('Qty: ${item.quantity}'),
            trailing: Text(
              '\$${item.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    final hasItems = widget.cartManager.items.isNotEmpty;
    final total = widget.cartManager.totalPrice;

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: hasItems
            ? () {
                final order = Order(
                  id: const Uuid().v4(),
                  items: widget.cartManager.getCartItems(),
                  type: _selectedSegment.contains(0)
                      ? BookingType.inPerson
                      : BookingType.scheduled,
                  memberName: _nameController.text.isEmpty
                      ? 'Guest'
                      : _nameController.text,
                  scheduledDate: _selectedDate,
                  scheduledTime: _formatTimeOfDay(_selectedTime),
                );
                widget.cartManager.clearCart();
                widget.onSubmit(order);
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            hasItems
                ? 'Submit Booking - \$${total.toStringAsFixed(2)}'
                : 'No Sessions Selected',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Booking Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking Type',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildBookingSegmentedType(),
            const SizedBox(height: 24),
            _buildTextField(),
            const SizedBox(height: 24),
            Text(
              'Schedule',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildDateTimePickers(),
            const SizedBox(height: 24),
            Text(
              'Booking Summary',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildBookingSummary(context),
            const SizedBox(height: 24),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }
}
