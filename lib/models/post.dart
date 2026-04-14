import 'package:flutter/material.dart';

class Post {
  final String title;
  final String description;
  final String author;
  final String date;
  final IconData icon;
  final String avatarUrl;

  const Post({
    required this.title,
    required this.description,
    required this.author,
    required this.date,
    required this.icon,
    this.avatarUrl = '',
  });
}
