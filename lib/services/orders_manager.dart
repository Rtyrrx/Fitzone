import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/order.dart';

class OrdersManager extends ChangeNotifier {
  static const String _ordersKey = 'fitzone_orders';
  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final storedOrders = prefs.getStringList(_ordersKey) ?? [];
    _orders
      ..clear()
      ..addAll(
        storedOrders.map(
          (orderJson) =>
              Order.fromJson(jsonDecode(orderJson) as Map<String, dynamic>),
        ),
      );
    notifyListeners();
  }

  void addOrder(Order order) {
    _orders.insert(0, order);
    _saveOrders();
    notifyListeners();
  }

  void removeOrder(String id) {
    _orders.removeWhere((order) => order.id == id);
    _saveOrders();
    notifyListeners();
  }

  Order? getOrder(String id) {
    try {
      return _orders.firstWhere((order) => order.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> _saveOrders() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _ordersKey,
      _orders.map((order) => jsonEncode(order.toJson())).toList(),
    );
  }
}
