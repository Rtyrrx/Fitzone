import 'cart_item.dart';

enum BookingType { inPerson, scheduled }

class Order {
  final int? databaseId;
  final String id;
  final String userId;
  final List<CartItem> items;
  final BookingType type;
  final String memberName;
  final DateTime? scheduledDate;
  final String? scheduledTime;
  final String status;
  final DateTime createdAt;

  Order({
    this.databaseId,
    required this.id,
    this.userId = 'local-user',
    required this.items,
    required this.type,
    required this.memberName,
    this.scheduledDate,
    this.scheduledTime,
    this.status = 'confirmed',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Order copyWith({
    int? databaseId,
    String? id,
    String? userId,
    List<CartItem>? items,
    BookingType? type,
    String? memberName,
    DateTime? scheduledDate,
    String? scheduledTime,
    String? status,
    DateTime? createdAt,
  }) {
    return Order(
      databaseId: databaseId ?? this.databaseId,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      type: type ?? this.type,
      memberName: memberName ?? this.memberName,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      databaseId: json['databaseId'] as int?,
      id: json['id'] as String,
      userId: json['userId'] as String? ?? 'local-user',
      items: (json['items'] as List<dynamic>)
          .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      type: BookingType.values.byName(json['type'] as String),
      memberName: json['memberName'] as String,
      scheduledDate: json['scheduledDate'] != null
          ? DateTime.parse(json['scheduledDate'] as String)
          : null,
      scheduledTime: json['scheduledTime'] as String?,
      status: json['status'] as String? ?? 'confirmed',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'databaseId': databaseId,
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'type': type.name,
      'memberName': memberName,
      'scheduledDate': scheduledDate?.toIso8601String(),
      'scheduledTime': scheduledTime,
      'status': status,
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
