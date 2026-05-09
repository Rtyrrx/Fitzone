import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/order.dart';
import 'shared_prefs_service.dart';

class OrdersManager extends ChangeNotifier {
  static const String _ordersKey = 'fitzone_orders';
  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  Future<void> init() async {
    final prefs = await SharedPrefsService.instance.ensureInitialized();
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

  Future<void> addOrder(Order order) async {
    _orders.insert(0, order);
    await _saveOrders();
    notifyListeners();
  }

  Future<void> removeOrder(String id) async {
    _orders.removeWhere((order) => order.id == id);
    await _saveOrders();
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
    final prefs = SharedPrefsService.instance.prefs;
    await prefs.setStringList(
      _ordersKey,
      _orders.map((order) => jsonEncode(order.toJson())).toList(),
    );
  }
}
