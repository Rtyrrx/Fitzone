import 'restaurant_item.dart';

class CartItem {
  final String id;
  final MembershipPlan item;
  int quantity;

  CartItem({required this.id, required this.item, this.quantity = 1});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as String,
      item: MembershipPlan.fromJson(json['item'] as Map<String, dynamic>),
      quantity: json['quantity'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'item': item.toJson(), 'quantity': quantity};
  }

  double get totalPrice => item.price * quantity;
}
