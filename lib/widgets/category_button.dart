import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final bool isSelected;
  final VoidCallback? onTap;
  final IconData? icon;

  const CategoryButton({
    Key? key,
    required this.title,
    required this.backgroundColor,
    this.textColor = Colors.white,
    this.isSelected = false,
    this.onTap,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? backgroundColor.withOpacity(0.9)
              : backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withOpacity(0.3),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor, size: 16),
              SizedBox(width: 8),
            ],
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget untuk list kategori horizontal
class CategoryButtonList extends StatefulWidget {
  final List<CategoryItem> categories;
  final Function(String)? onCategorySelected;
  final String? selectedCategory;

  const CategoryButtonList({
    Key? key,
    required this.categories,
    this.onCategorySelected,
    this.selectedCategory,
  }) : super(key: key);

  @override
  _CategoryButtonListState createState() => _CategoryButtonListState();
}

class _CategoryButtonListState extends State<CategoryButtonList> {
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = widget.categories[index];
          final isSelected = _selectedCategory == category.id;

          return CategoryButton(
            title: category.title,
            backgroundColor: category.color,
            textColor: category.textColor,
            isSelected: isSelected,
            icon: category.icon,
            onTap: () {
              setState(() {
                _selectedCategory = category.id;
              });
              if (widget.onCategorySelected != null) {
                widget.onCategorySelected!(category.id);
              }
            },
          );
        },
      ),
    );
  }
}

// Model untuk kategori
class CategoryItem {
  final String id;
  final String title;
  final Color color;
  final Color textColor;
  final IconData? icon;

  CategoryItem({
    required this.id,
    required this.title,
    required this.color,
    this.textColor = Colors.white,
    this.icon,
  });
}
