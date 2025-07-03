import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../widgets/menu_item_card.dart';
import '../widgets/category_button.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String selectedCategory = 'all';
  List<MenuItem> menuItems = [];
  List<MenuItem> filteredMenuItems = [];

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
  }

  void _loadMenuItems() {
    // Sample menu items
    menuItems = [
      MenuItem(
        id: '1',
        name: 'Pecel Sembal Tumpang',
        description: 'Pecel Sambel Tumpang, Pecel Nasi Uduk',
        rating: 4.5,
        imageUrl: 'assets/images/pecel1.jpg',
        price: 15000,
        category: 'special',
      ),
      MenuItem(
        id: '2',
        name: 'Pecel Sambel',
        description: 'Pecel tradisional dengan sambel khas',
        rating: 4.5,
        imageUrl: 'assets/images/pecel2.jpg',
        price: 12000,
        category: 'special',
      ),
      MenuItem(
        id: '3',
        name: 'Gado-Gado',
        description: 'Gado-gado dengan bumbu kacang spesial',
        rating: 4.3,
        imageUrl: 'assets/images/gado.jpg',
        price: 13000,
        category: 'popular',
      ),
      MenuItem(
        id: '4',
        name: 'Es Teh Manis',
        description: 'Es teh manis segar',
        rating: 4.0,
        imageUrl: 'assets/images/es_teh.jpg',
        price: 5000,
        category: 'drink',
      ),
      MenuItem(
        id: '5',
        name: 'Jus Jeruk',
        description: 'Jus jeruk segar tanpa gula',
        rating: 4.2,
        imageUrl: 'assets/images/jus_jeruk.jpg',
        price: 8000,
        category: 'drink',
      ),
    ];

    _filterMenuItems();
  }

  void _filterMenuItems() {
    setState(() {
      if (selectedCategory == 'all') {
        filteredMenuItems = menuItems;
      } else {
        filteredMenuItems = menuItems
            .where((item) => item.category == selectedCategory)
            .toList();
      }
    });
  }

  void _onCategorySelected(String categoryId) {
    setState(() {
      selectedCategory = categoryId;
    });
    _filterMenuItems();
  }

  void _addToCart(MenuItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} ditambahkan ke keranjang'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      CategoryItem(
        id: 'all',
        title: 'Semua',
        color: Colors.grey[600]!,
        icon: Icons.restaurant,
      ),
      CategoryItem(
        id: 'special',
        title: 'Menu Spesial',
        color: Colors.green,
        icon: Icons.star,
      ),
      CategoryItem(
        id: 'popular',
        title: 'Menu Terfaris',
        color: Colors.red,
        icon: Icons.local_fire_department,
      ),
      CategoryItem(
        id: 'drink',
        title: 'Minuman',
        color: Colors.blue,
        icon: Icons.local_drink,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Menu Lengkap',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black87),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Categories
          Container(
            color: Colors.white,
            child: CategoryButtonList(
              categories: categories,
              selectedCategory: selectedCategory,
              onCategorySelected: _onCategorySelected,
            ),
          ),
          SizedBox(height: 16),

          // Menu Items
          Expanded(
            child: filteredMenuItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.restaurant_menu,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Tidak ada menu tersedia',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: filteredMenuItems.length,
                    itemBuilder: (context, index) {
                      final menuItem = filteredMenuItems[index];
                      return MenuItemCard(
                        menuItem: menuItem,
                        onTap: () {
                          // Navigate to detail page
                          _showMenuDetail(menuItem);
                        },
                        onAddToCart: () => _addToCart(menuItem),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showMenuDetail(MenuItem menuItem) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12, bottom: 20),
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Menu image
            Container(
              height: 200,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(menuItem.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Menu details
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menuItem.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 20),
                        SizedBox(width: 4),
                        Text(
                          menuItem.rating.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      menuItem.description,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Harga: ${menuItem.formattedPrice}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[600],
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _addToCart(menuItem);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Tambah ke Keranjang',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
