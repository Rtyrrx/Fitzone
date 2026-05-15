class BookingHistoryLineItem {
  final int? membershipId;
  final int? centerId;
  final String name;
  final String description;
  final String duration;
  final double unitPrice;
  final int quantity;
  final double lineTotal;

  const BookingHistoryLineItem({
    this.membershipId,
    this.centerId,
    required this.name,
    required this.description,
    required this.duration,
    required this.unitPrice,
    required this.quantity,
    required this.lineTotal,
  });

  factory BookingHistoryLineItem.fromJson(Map<String, dynamic> json) {
    return BookingHistoryLineItem(
      membershipId: json['membershipId'] as int?,
      centerId: json['centerId'] as int?,
      name: json['name'] as String? ?? 'Membership',
      description: json['description'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0,
      quantity: json['quantity'] as int? ?? 0,
      lineTotal: (json['lineTotal'] as num?)?.toDouble() ?? 0,
    );
  }
}

class BookingHistoryEntry {
  final String id;
  final String bookingId;
  final String userId;
  final String userEmail;
  final String memberName;
  final String eventType;
  final String bookingType;
  final String bookingStatus;
  final int itemCount;
  final double totalPrice;
  final String itemSummary;
  final DateTime createdAt;
  final DateTime eventAt;
  final DateTime? scheduledDate;
  final String? scheduledTime;
  final List<BookingHistoryLineItem> items;

  const BookingHistoryEntry({
    required this.id,
    required this.bookingId,
    required this.userId,
    required this.userEmail,
    required this.memberName,
    required this.eventType,
    required this.bookingType,
    required this.bookingStatus,
    required this.itemCount,
    required this.totalPrice,
    required this.itemSummary,
    required this.createdAt,
    required this.eventAt,
    required this.scheduledDate,
    required this.scheduledTime,
    required this.items,
  });

  bool get isCancellation => eventType == 'cancelled';
  String get eventLabel => isCancellation ? 'Cancelled' : 'Booked';

  factory BookingHistoryEntry.fromJson(Map<String, dynamic> json) {
    return BookingHistoryEntry(
      id: json['id'] as String,
      bookingId: json['bookingId'] as String? ?? '',
      userId: json['userId'] as String? ?? 'local-user',
      userEmail: json['userEmail'] as String? ?? '',
      memberName: json['memberName'] as String? ?? 'Guest',
      eventType: json['eventType'] as String? ?? 'created',
      bookingType: json['bookingType'] as String? ?? 'In Person',
      bookingStatus: json['bookingStatus'] as String? ?? 'confirmed',
      itemCount: json['itemCount'] as int? ?? 0,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0,
      itemSummary: json['itemSummary'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      eventAt: DateTime.parse(
        (json['eventAt'] as String?) ?? (json['createdAt'] as String),
      ),
      scheduledDate: json['scheduledDate'] != null
          ? DateTime.parse(json['scheduledDate'] as String)
          : null,
      scheduledTime: json['scheduledTime'] as String?,
      items: (json['itemsReadable'] as List<dynamic>? ?? const [])
          .map(
            (item) =>
                BookingHistoryLineItem.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}
