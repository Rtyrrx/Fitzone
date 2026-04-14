import 'package:flutter/material.dart';

class SportCategory {
  final String name;
  final IconData icon;
  final Color color;
  final int centerCount;
  final String imageUrl;

  const SportCategory({
    required this.name,
    required this.icon,
    required this.color,
    required this.centerCount,
    this.imageUrl = '',
  });
}
