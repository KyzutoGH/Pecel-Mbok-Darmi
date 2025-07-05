// File: widgets/category_button.dart
import 'package:flutter/material.dart';

// Model untuk CategoryItem
class CategoryItem {
  final String id;
  final String title;
  final Color color;
  final IconData icon;

  CategoryItem({
    required this.id,
    required this.title,
    required this.color,
    required this.icon,
  });
}

// Widget CategoryButtonList - Layout Equal Width (seperti di gambar)
class CategoryButtonList extends StatelessWidget {
  final List<CategoryItem> categories;
  final Function(String) onCategorySelected;
  final String? selectedCategory;

  const CategoryButtonList({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
    this.selectedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: categories.map((category) {
          bool isSelected = selectedCategory == category.id;
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: CategoryButton(
                category: category,
                onTap: () => onCategorySelected(category.id),
                isSelected: isSelected,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// Widget CategoryButton individual
class CategoryButton extends StatelessWidget {
  final CategoryItem category;
  final VoidCallback onTap;
  final bool isSelected;

  const CategoryButton({
    Key? key,
    required this.category,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? category.color.withOpacity(0.9) : category.color,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isSelected ? 0.15 : 0.1),
              blurRadius: isSelected ? 6 : 4,
              offset: Offset(0, isSelected ? 3 : 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              category.icon,
              color: Colors.white,
              size: isSelected ? 20 : 18,
            ),
            SizedBox(width: 6),
            Flexible(
              child: Text(
                category.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSelected ? 13 : 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Alternatif dengan ScrollView horizontal (jika kategori banyak)
class CategoryButtonScrollList extends StatelessWidget {
  final List<CategoryItem> categories;
  final Function(String) onCategorySelected;
  final String? selectedCategory;

  const CategoryButtonScrollList({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
    this.selectedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          bool isSelected = selectedCategory == category.id;
          return Container(
            margin: EdgeInsets.only(right: 12),
            child: CategoryButton(
              category: category,
              onTap: () => onCategorySelected(category.id),
              isSelected: isSelected,
            ),
          );
        },
      ),
    );
  }
}
