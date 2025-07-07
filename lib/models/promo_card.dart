class PromoCard {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String discount;
  final String? description;
  final DateTime? validUntil;

  PromoCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.discount,
    this.description,
    this.validUntil,
  });

  // Factory constructor for creating from JSON
  factory PromoCard.fromJson(Map<String, dynamic> json) {
    return PromoCard(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      discount: json['discount'] ?? '',
      description: json['description'],
      validUntil: json['validUntil'] != null 
          ? DateTime.parse(json['validUntil'])
          : null,
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'discount': discount,
      'description': description,
      'validUntil': validUntil?.toIso8601String(),
    };
  }
}