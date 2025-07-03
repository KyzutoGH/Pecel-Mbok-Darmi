class MenuItem {
  final String id;
  final String name;
  final String description;
  final double rating;
  final String imageUrl;
  final double price;
  final String category;
  final bool isAvailable;
  final List<String> ingredients;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.rating,
    required this.imageUrl,
    required this.price,
    required this.category,
    this.isAvailable = true,
    this.ingredients = const [],
  });

  // Factory method untuk membuat menu item dari JSON
  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      category: json['category'] ?? '',
      isAvailable: json['isAvailable'] ?? true,
      ingredients: List<String>.from(json['ingredients'] ?? []),
    );
  }

  // Method untuk convert ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'rating': rating,
      'imageUrl': imageUrl,
      'price': price,
      'category': category,
      'isAvailable': isAvailable,
      'ingredients': ingredients,
    };
  }

  // Method untuk copy dengan perubahan
  MenuItem copyWith({
    String? id,
    String? name,
    String? description,
    double? rating,
    String? imageUrl,
    double? price,
    String? category,
    bool? isAvailable,
    List<String>? ingredients,
  }) {
    return MenuItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      category: category ?? this.category,
      isAvailable: isAvailable ?? this.isAvailable,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  // Method untuk format harga
  String get formattedPrice {
    return 'Rp ${price.toStringAsFixed(0)}';
  }

  // Method untuk cek rating
  bool get isHighRated {
    return rating >= 4.0;
  }
}
