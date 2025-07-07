import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../widgets/menu_item_card.dart';

class MenuScreen extends StatefulWidget {
  final String? selectedCategory;

  const MenuScreen({Key? key, this.selectedCategory}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<MenuItem> allMenuItems = [];
  List<MenuItem> filteredMenuItems = [];
  String? selectedCategory;
  
  // Categories for filtering
  final List<Map<String, dynamic>> categories = [
    {'id': 'all', 'title': 'Semua', 'icon': Icons.restaurant_menu},
    {'id': 'special', 'title': 'Menu Spesial', 'icon': Icons.star},
    {'id': 'popular', 'title': 'Menu Terlaris', 'icon': Icons.local_fire_department},
    {'id': 'drink', 'title': 'Minuman', 'icon': Icons.local_drink},
  ];

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory ?? 'all';
    _loadMenuItems();
  }

  void _loadMenuItems() {
    // Load all menu items (this would typically come from a database or API)
    allMenuItems = [
      MenuItem(
        id: '1',
        name: 'Pecel Sembal Tumpang',
        description: 'Pecel Sambel Tumpang, Pecel Nasi Uduk dengan cita rasa yang khas',
        rating: 4.5,
        imageUrl: 'images/pecel2.jpg',
        price: 15000,
        category: 'special',
      ),
      MenuItem(
        id: '2',
        name: 'Pecel Sambel',
        description: 'Pecel tradisional dengan sambel khas yang pedas dan gurih',
        rating: 4.5,
        imageUrl: 'images/pecel2.jpg',
        price: 12000,
        category: 'special',
      ),
      MenuItem(
        id: '3',
        name: 'Pecel Komplit',
        description: 'Pecel lengkap dengan lauk pauk dan sayuran segar',
        rating: 4.8,
        imageUrl: 'images/pecel1.jpg',
        price: 18000,
        category: 'popular',
      ),
      MenuItem(
        id: '4',
        name: 'Pecel Ayam',
        description: 'Pecel dengan ayam goreng yang renyah dan bumbu pecel yang lezat',
        rating: 4.6,
        imageUrl: 'images/pecel1.jpg',
        price: 20000,
        category: 'popular',
      ),
      MenuItem(
        id: '5',
        name: 'Pecel Tempe',
        description: 'Pecel dengan tempe goreng dan sayuran segar',
        rating: 4.3,
        imageUrl: 'images/pecel2.jpg',
        price: 10000,
        category: 'special',
      ),
      MenuItem(
        id: '6',
        name: 'Es Teh Manis',
        description: 'Es teh manis segar untuk menemani makan',
        rating: 4.2,
        imageUrl: 'images/pecel1.jpg',
        price: 5000,
        category: 'drink',
      ),
      MenuItem(
        id: '7',
        name: 'Es Jeruk',
        description: 'Es jeruk segar dengan rasa asam manis yang menyegarkan',
        rating: 4.4,
        imageUrl: 'images/pecel2.jpg',
        price: 7000,
        category: 'drink',
      ),
      MenuItem(
        id: '8',
        name: 'Kopi Tubruk',
        description: 'Kopi tubruk tradisional dengan rasa yang kuat',
        rating: 4.5,
        imageUrl: 'images/pecel1.jpg',
        price: 8000,
        category: 'drink',
      ),
    ];

    _filterMenuItems();
  }

  void _filterMenuItems() {
    setState(() {
      if (selectedCategory == 'all') {
        filteredMenuItems = allMenuItems;
      } else {
        filteredMenuItems = allMenuItems
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
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Menu',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category filter
          _buildCategoryFilter(),
          
          // Menu items
          Expanded(
            child: _buildMenuList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            bool isSelected = selectedCategory == category['id'];
            return Container(
              margin: const EdgeInsets.only(right: 8),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _onCategorySelected(category['id']),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.orange : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Colors.orange : Colors.grey[300]!,
                        width: 1,
                      ),
                      boxShadow: isSelected ? [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ] : [],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          category['icon'],
                          color: isSelected ? Colors.white : Colors.grey[600],
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          category['title'],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[600],
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMenuList() {
    if (filteredMenuItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Tidak ada menu tersedia',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredMenuItems.length,
      itemBuilder: (context, index) {
        final item = filteredMenuItems[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: MenuItemCard(
            menuItem: item,
            onTap: () => _showMenuDetail(item),
            onAddToCart: () => _addToCart(item),
          ),
        );
      },
    );
  }

  void _showMenuDetail(MenuItem menuItem) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 20),
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
                margin: const EdgeInsets.symmetric(horizontal: 20),
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
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menuItem.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.orange, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              menuItem.rating.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          menuItem.description,
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Harga: ${menuItem.formattedPrice}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[600],
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _addToCart(menuItem);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}