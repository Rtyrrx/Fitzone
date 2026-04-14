import 'cart_item.dart';

enum BookingType { inPerson, scheduled }

class Order {
  final String id;
  final List<CartItem> items;
  final BookingType type;
  final String memberName;
  final DateTime? scheduledDate;
  final String? scheduledTime;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.items,
    required this.type,
    required this.memberName,
    this.scheduledDate,
    this.scheduledTime,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      type: BookingType.values.byName(json['type'] as String),
      memberName: json['memberName'] as String,
      scheduledDate: json['scheduledDate'] != null
          ? DateTime.parse(json['scheduledDate'] as String)
          : null,
      scheduledTime: json['scheduledTime'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((item) => item.toJson()).toList(),
      'type': type.name,
      'memberName': memberName,
      'scheduledDate': scheduledDate?.toIso8601String(),
      'scheduledTime': scheduledTime,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  double get totalPrice => items.fold(0, (sum, item) => sum + item.totalPrice);

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  String get statusText {
    switch (type) {
      case BookingType.inPerson:
        return 'In Person';
      case BookingType.scheduled:
        return 'Scheduled';
    }
  }
}
