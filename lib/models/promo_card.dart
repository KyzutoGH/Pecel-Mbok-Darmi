class PromoCard {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String? discount;
  final bool isActive;

  PromoCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.discount,
    this.isActive = true,
  });

  // Factory method untuk membuat promo card dari JSON
  factory PromoCard.fromJson(Map<String, dynamic> json) {
    return PromoCard(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      discount: json['discount'],
      isActive: json['isActive'] ?? true,
    );
  }

  // Method untuk convert ke JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'discount': discount,
      'isActive': isActive,
    };
  }

  // Method untuk copy dengan perubahan
  PromoCard copyWith({
    String? title,
    String? subtitle,
    String? imageUrl,
    String? discount,
    bool? isActive,
  }) {
    return PromoCard(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imageUrl: imageUrl ?? this.imageUrl,
      discount: discount ?? this.discount,
      isActive: isActive ?? this.isActive,
    );
  }
}
