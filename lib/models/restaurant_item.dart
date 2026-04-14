class MembershipPlan {
  final String name;
  final double price;
  final String description;
  final String duration;
  final String imageUrl;

  const MembershipPlan({
    required this.name,
    required this.price,
    required this.description,
    this.duration = 'Monthly',
    this.imageUrl = '',
  });

  factory MembershipPlan.fromJson(Map<String, dynamic> json) {
    return MembershipPlan(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      duration: json['duration'] as String? ?? 'Monthly',
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'duration': duration,
      'imageUrl': imageUrl,
    };
  }
}
